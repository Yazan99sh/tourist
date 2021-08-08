import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_orders/ui/screen/orders_list/order_list_screen.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state.dart';

class OrderListStateLoading extends OrdersListState {
  OrderListStateLoading(OrdersListScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('${S.of(context).loading}'), CircularProgressIndicator()],
        ),
      ],
    );
  }
}