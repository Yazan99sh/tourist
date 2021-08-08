import 'package:flutter/material.dart';
import 'package:tourists/module_orders/ui/screen/orders_list/order_list_screen.dart';

abstract class OrdersListState {
  OrdersListScreen screen;
  OrdersListState(this.screen);

  Widget getUI(BuildContext context);
}