import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/ui/screens/add_location/add_location.dart';
import 'package:tourists/module_locations/ui/states/add_location_state/add_location_state.dart';

class AddLocationStateInit extends AddLocationState {
  final LocationDetailsModel detailsModel;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String image;

  AddLocationStateInit(AddLocationScreen screen, this.detailsModel)
      : super(screen) {
    if (this.detailsModel != null) {
      _nameController.text = detailsModel.name;
      _descriptionController.text = detailsModel.description;
      if (detailsModel.regionImage != null) {
        if (detailsModel.regionImage.isNotEmpty) {
          image = detailsModel.regionImage[0].path;
        }
      }
    }
  }

  @override
  Widget getUI(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ImagePicker()
                    .getImage(source: ImageSource.gallery)
                    .then((value) {
                  screen.uploadImage(value.path, detailsModel);
                });
              },
              child: Center(
                child: image == null
                    ? Image.asset(
                        'resources/images/logo.png',
                        height: 96,
                        width: 96,
                      )
                    : Image.network(
                        image,
                        height: 96,
                        width: 96,
                        errorBuilder: (c, e, s) {
                          return Image.asset(
                            'resources/images/logo.png',
                            height: 96,
                            width: 96,
                          );
                        },
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: S.of(context).locationName,
                labelText: S.of(context).locationName,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: S.of(context).locationDescription,
                labelText: S.of(context).locationDescription,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              detailsModel.name = _nameController.text;
              detailsModel.description = _descriptionController.text;
              screen.saveLocation(detailsModel);
            },
            child: Text(S.of(context).save),
          ),
        ],
      ),
    );
  }
}
