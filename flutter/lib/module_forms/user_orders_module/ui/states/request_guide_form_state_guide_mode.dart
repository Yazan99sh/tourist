import 'package:flutter/material.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form.dart';
import 'package:tourists/module_forms/user_orders_module/ui/widget/request_guide_form.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';

class RequestGuideFormStateGuideMode extends RequestGuideFormState {
  GuideListItemModel guide;
  RequestGuideFormStateGuideMode(RequestGuideScreen screen, this.guide) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return RequestGuideForm(
      onRequestGuide: (request) {
        screen.requestGuide(request);
      },
      guide: guide,
    );
  }

}