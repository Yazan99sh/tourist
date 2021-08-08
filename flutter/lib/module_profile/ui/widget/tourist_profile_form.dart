import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';

class TouristProfileForm extends StatefulWidget {
  final ProfileModel profile;
  final Function(String, ProfileModel) onImageSelected;
  final Function(ProfileModel) saveProfile;

  TouristProfileForm({
    this.profile,
    this.onImageSelected,
    this.saveProfile,
  });

  @override
  State<StatefulWidget> createState() => _TouristProfileFormState(profile);
}

class _TouristProfileFormState extends State<TouristProfileForm> {
  final _nameController = TextEditingController();
  final languages = <String>{};

  _TouristProfileFormState(ProfileModel profileModel) {
    if (profileModel != null) {
      languages.addAll(profileModel.languages ?? []);
      _nameController.text = profileModel.name?.trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    var profile = widget.profile;

    var picker = ImagePicker();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).viewInsets.bottom == 0 ? 88 : 0,
            child: Stack(
              children: [
                Positioned.fill(
                    child: FadeInImage.assetNetwork(
                  placeholder: 'resources/images/logo.jpg',
                  image: '${profile.image}'.contains('http')
                      ? '${profile.image.substring(profile.image.lastIndexOf('http'))}'
                      : Urls.imagesRoot + profile.image,
                  fit: BoxFit.contain,
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
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _nameController,
              onEditingComplete: () {
                profile.name = _nameController.text;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: S.of(context).myName,
                hintText: S.of(context).myName,
              ),
            ),
          ),
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ListTile(
              //   title: Text(
              //     S.of(context).language,
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Flex(
              //   direction: Axis.vertical,
              //   children: [
              //     CheckboxListTile(
              //       title: Text(S.of(context).language_arabic),
              //       onChanged: (bool value) {
              //         if (value) {
              //           languages.add('ar');
              //         } else {
              //           languages.remove('ar');
              //         }
              //         profile.languages = languages.toList();
              //         if (mounted) setState(() {});
              //       },
              //       value: profile.languages != null
              //           ? profile.languages.contains('ar')
              //           : false,
              //     ),
              //     CheckboxListTile(
              //       title: Text(S.of(context).language_english),
              //       onChanged: (bool value) {
              //         if (value) {
              //           languages.add('en');
              //         } else {
              //           languages.remove('en');
              //         }
              //         profile.languages = languages.toList();
              //         if (mounted) setState(() {});
              //       },
              //       value: profile.languages != null
              //           ? profile.languages.contains('en')
              //           : false,
              //     ),
              //   ],
              // ),
            ],
          ),
          GestureDetector(
            onTap: () {
              profile.name = _nameController.text;
              profile.languages = languages.toList();
              widget.saveProfile(profile);
            },
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
          )
        ],
      ),
    );
  }
}
