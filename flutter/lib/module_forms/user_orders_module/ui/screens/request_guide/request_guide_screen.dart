
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/bloc/request_guide/request_guide.bloc.dart';
import 'package:tourists/module_forms/user_orders_module/model/request_guide/request_guide.model.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form.dart';
import 'package:tourists/module_guide/nav_arguments/request_guide/request_guide_navigation.dart';

@provide
class RequestGuideScreen extends StatefulWidget {
  final RequestGuideBloc _requestGuideBloc;

  RequestGuideScreen(this._requestGuideBloc);

  @override
  State<StatefulWidget> createState() => _RequestGuideScreenState();

  void requestGuide(RequestGuideModel request) {
    _requestGuideBloc.requestGuide(this, request);
  }
}

class _RequestGuideScreenState extends State<RequestGuideScreen> {
  RequestGuideFormState _currentState;
  bool inited = false;

  @override
  void initState() {
    widget._requestGuideBloc.guideInfoStream.listen((event) {
      _currentState = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!inited) {
      inited = true;
      RequestGuideNavigationArguments args = ModalRoute.of(context).settings.arguments;
      widget._requestGuideBloc.requestInfo(widget, args.guideId, args.cityId);
    }

    return Scaffold(
      appBar: AppBar(),
      body: _currentState != null ? _currentState.getUI(context) : Container(),
    );
  }
}
