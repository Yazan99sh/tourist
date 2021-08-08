import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/ui/widgets/add_location_dialog/add_location_dialog.dart';
import 'package:tourists/module_locations/ui/widgets/guide_locations/guide_locations.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_search/bloc/search_bloc/search_bloc.dart';
import 'package:tourists/utils/keyboard_detector/keyboard_detector.dart';

class GuideProfileFormWidget extends StatefulWidget {
  final ProfileModel userProfile;
  final SearchBloc searchBloc;
  final Function(String path, ProfileModel profile) onImageSelected;
  final Function(ProfileModel profileModel) onProfileSaved;

  GuideProfileFormWidget({
    this.userProfile,
    this.searchBloc,
    this.onImageSelected,
    this.onProfileSaved,
  });

  @override
  State<StatefulWidget> createState() =>
      _GuideProfileFormWidgetState(userProfile);
}

class _GuideProfileFormWidgetState extends State<GuideProfileFormWidget> {
  final _registerGuideFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final languages = <String>{};
  final locations = <String>{};
  final services = <String>{};

  ProfileModel userProfile;

  _GuideProfileFormWidgetState(this.userProfile) {
    _nameController.text = userProfile?.name?.trim();
    _phoneController.text = userProfile?.phone;
    languages.addAll(userProfile?.languages ?? []);
    locations.addAll(userProfile?.locations ?? []);
    services.addAll(userProfile?.services ?? []);
  }

  @override
  Widget build(BuildContext context) {
    var profile = userProfile;
    var picker = ImagePicker();
    profile ??= ProfileModel();

    return Form(
      key: _registerGuideFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          children: [
            if (!KeyboardDetector.isUp(context))
              Container(
                height: 88,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: FadeInImage.assetNetwork(
                      placeholder: 'resources/images/logo.jpg',
                      image: '${profile.image}'.contains('http')
                          ? '${profile.image}'
                          : Urls.imagesRoot + '${profile.image}',
                      fit: BoxFit.contain,
                      imageErrorBuilder: (o, e, s) {
                        print(e.toString());
                        return Image.asset('resources/images/logo.jpg');
                      },
                    )),
                    Positioned(
                      right: 16,
                      top: 16,
                      child: GestureDetector(
                        onTap: () {
                          picker
                              .getImage(
                                  source: ImageSource.gallery, imageQuality: 70)
                              .then((image) {
                            if (image != null) {
                              profile.name = _nameController.text;
                              profile.phone = _phoneController.text;
                              profile.image = profile.image;
                              profile.languages = languages.toList();
                              profile.locations = locations.toList();
                              profile.services = services.toList();
                              widget.onImageSelected(image.path, profile);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            else
              Container(),
            ListTile(
              title: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: S.of(context).myName,
                  hintText: S.of(context).myName,
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return '${S.of(context).valueRequred}';
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              title: TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: S.of(context).myPhoneNumber,
                  hintText: S.of(context).myPhoneNumber,
                ),
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val.isEmpty) {
                    return '${S.of(context).valueRequred}';
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              title: Text(
                S.of(context).language,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CheckboxListTile(
              title: Text(S.of(context).language_arabic),
              value: languages.contains('ar'),
              onChanged: (bool value) {
                if (value) {
                  languages.add('ar');
                } else {
                  languages.remove('ar');
                }
                if (mounted) setState(() {});
                if (mounted) setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text(S.of(context).language_english),
              value: languages.contains('en'),
              onChanged: (bool value) {
                if (value) {
                  languages.add('en');
                } else {
                  languages.remove('en');
                }
                if (mounted) setState(() {});
              },
            ),
            ListTile(
              title: Text(
                S.of(context).services,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CheckboxListTile(
              title: Text(S.of(context).car),
              value: services.contains('car'),
              onChanged: (bool value) {
                if (value) {
                  services.add('car');
                } else {
                  services.remove('car');
                }
                if (mounted) setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text(S.of(context).hotel),
              value: services.contains('hotel'),
              onChanged: (bool value) {
                if (value) {
                  services.add('hotel');
                  print('Changing Hotel, +');
                } else {
                  services.remove('hotel');
                  print('Changing Hotel, -');
                }
                if (mounted) setState(() {});
              },
            ),
            ListTile(
              title: Text(
                S.of(context).locationsYouWorkIn,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      child: AddLocationDialog(widget.searchBloc));
                },
                icon: Icon(
                  Icons.add_circle,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              height: 96,
              // This is where we add locations
              child: GuideLocations(
                  locations: profile.availableLocations ?? [],
                  selectedLocations: locations.toList(),
                  onLocationSelected: (id) {
                    if (locations.contains(id.toString())) {
                      locations.remove(id.toString());
                    } else {
                      locations.add(id.toString());
                    }
                    if (mounted) setState(() {});
                  }),
            ),
            GestureDetector(
              onTap: () {
                if (_registerGuideFormKey.currentState.validate()) {
                  // var createProfileRequest = ProfileModel(
                  //   name: _nameController.text,
                  //   phone: _phoneController.text,
                  //   image: profile.image,
                  //   languages: languages.toList(),
                  //   locations: locations.toList(),
                  //   services: services.toList(),
                  // );
                  profile.name = _nameController.text;
                  profile.phone = _phoneController.text;
                  profile.image = profile.image;
                  profile.languages = languages.toList();
                  profile.locations = locations.toList();
                  profile.services = services.toList();
                  widget.onProfileSaved(profile);
                }
              },
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).accentColor),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).saveProfile,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
