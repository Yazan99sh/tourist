import 'package:flutter/cupertino.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';

abstract class RequestGuideFormState {
  RequestGuideScreen screen;
  RequestGuideFormState(this.screen);

  Widget getUI(BuildContext context);
}