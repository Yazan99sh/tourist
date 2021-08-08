import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_orders/ui/screen/orders_list/order_list_screen.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state.dart';

class OrderListStateError extends OrdersListState {
  String error;
  OrderListStateError(OrdersListScreen screen, this.error) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${error}'),
    );
  }
}