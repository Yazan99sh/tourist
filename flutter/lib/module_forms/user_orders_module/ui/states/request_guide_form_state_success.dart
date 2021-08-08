import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form.dart';
import 'package:tourists/module_orders/orders_routes.dart';

class RequestGuideFormStateSuccess extends RequestGuideFormState {
  RequestGuideFormStateSuccess(RequestGuideScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
              Icons.check_circle,
                color: Color(0xff05F29B),
                size: 125,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Text(
              '${S.of(context).requestSuccess}!',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:25.0,right: 8,left: 8),
          child: Center(
            child: FlatButton(
              color: Colors.grey[300],
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(OrdersRoutes.ordersList);
              },
              child: Text('${S.of(context).next}',),
            ),
          ),
        ),
      ],
    );
  }
}
