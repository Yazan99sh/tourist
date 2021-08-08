import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_orders/ui/screen/guide_orders/guide_orders.dart';

@provide
class GuideHomeScreen extends StatefulWidget {
  final GuideOrdersScreen _ordersListScreen;

  GuideHomeScreen(this._ordersListScreen);

  @override
  State<StatefulWidget> createState() => GuideHomeScreenState(0);
}

class GuideHomeScreenState extends State<GuideHomeScreen> {
  int currentPosition;

  GuideHomeScreenState(this.currentPosition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._ordersListScreen,
    );
  }
}
