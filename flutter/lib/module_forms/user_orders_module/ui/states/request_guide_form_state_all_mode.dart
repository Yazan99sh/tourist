import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form.dart';
import 'package:tourists/module_forms/user_orders_module/ui/widget/request_guide_at_location_form.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';

class RequestGuideFormStateAllMode extends RequestGuideFormState {
  LocationDetailsModel locationDetailsModel;
  GuideListItemModel guideListItemModel;
  RequestGuideFormStateAllMode(RequestGuideScreen screen, this.locationDetailsModel, this.guideListItemModel) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return RequestGuideAtLocationForm(
      onRequestGuide: (request) {
        screen.requestGuide(request);
      },
      location: locationDetailsModel,
      guide: guideListItemModel,
    );
  }

}