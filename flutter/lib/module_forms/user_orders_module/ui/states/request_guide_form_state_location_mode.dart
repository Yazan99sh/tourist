import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form.dart';
import 'package:tourists/module_forms/user_orders_module/ui/widget/request_location_form.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';

class RequestGuideFormStateLocationMode extends RequestGuideFormState {
  LocationDetailsModel location;

  RequestGuideFormStateLocationMode(RequestGuideScreen screen, this.location)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return RequestLocationFormWidget(
      location: location,
      onRequestGuide: (request) {
        screen.requestGuide(request);
      },
    );
  }
}
