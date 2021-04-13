import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/ui/screen/orders_list/order_list_screen.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state.dart';
import 'package:tourists/module_orders/ui/widget/order_item/order_item.dart';

class OrderListStateGuideOrdersLoaded extends OrdersListState {
  final PageController _pageController = PageController();
  final List<OrderModel> ordersList;
  int activePosition = 0;

  OrderListStateGuideOrdersLoaded(OrdersListScreen screen, this.ordersList)
      : super(screen) {
    print('User Orders: ${ordersList?.length}');
  }

  @override
  Widget getUI(BuildContext context) {
    List<Widget> pageLayout = [];
    // region Header
    pageLayout.add(_getFilterBar(context));

    // Here we have all the payments that is sent from the user.
    ListView sentOrders = _getSentOrdersList(context);
    ListView pendingPaymentOrders = _getPendingPaymentList(context);
    ListView onGoing = _getOnGoingOrdersList(context);
    ListView done = _getFinishedOrdersList();

    PageView orderPages = PageView(
      controller: _pageController,
      onPageChanged: (position) {
        activePosition = position;
        screen.refresh(this);
      },
      children: <Widget>[sentOrders, pendingPaymentOrders, onGoing, done],
    );

    pageLayout.add(Expanded(
      child: orderPages,
    ));

    return Flex(
      direction: Axis.vertical,
      children: pageLayout,
    );
  }

  Widget _getFilterBar(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 0;
                _pageController.jumpToPage(0);
                screen.refresh(this);
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.white, width: 1)),
                      color: activePosition == 0
                          ? Colors.greenAccent
                          : Colors.black12),
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).sentPending,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            activePosition == 0 ? Colors.white : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 1;
                _pageController.jumpToPage(1);
                screen.refresh(this);
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.white, width: 1)),
                      color: activePosition == 1
                          ? Colors.greenAccent
                          : Colors.black12),
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).pendingPayment,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            activePosition == 1 ? Colors.white : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 2;
                _pageController.jumpToPage(2);
                screen.refresh(this);
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.white, width: 1)),
                      color: activePosition == 2
                          ? Colors.greenAccent
                          : Colors.black12),
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).payedOnGoing,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            activePosition == 2 ? Colors.white : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 3;
                _pageController.jumpToPage(3);
                screen.refresh(this);
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.white, width: 1)),
                      color: activePosition == 3
                          ? Colors.greenAccent
                          : Colors.black12),
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).finishedOrders,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            activePosition == 3 ? Colors.white : Colors.black),
                  )),
            )),
      ],
    );
  }

  Widget _getSentOrdersList(BuildContext context) {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'pending' && element.roomId == null) {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: false,
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[
              Container(
                height: 300,
                child: Center(
                  child: Text('Empty List'),
                ),
              )
            ],
    );
  }

  Widget _getPendingPaymentList(BuildContext context) {
    if (ordersList == null) {
      print('Null Orders List');
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'pendingPayment') {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: false,
          onPayOrder: (order) {
            screen.payOrder(order);
          },
          onAcceptOrder: (order) {
            screen.payOrder(order);
          },
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[
              Container(height: 300, child: Center(child: Text('Empty List')))
            ],
    );
  }

  Widget _getOnGoingOrdersList(BuildContext context) {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'onGoing') {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: true,
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[
              Container(height: 300, child: Center(child: Text('Empty List')))
            ],
    );
  }

  Widget _getFinishedOrdersList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'finished' || element.status == 'done') {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: true,
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[
              Container(height: 300, child: Center(child: Text('Empty List')))
            ],
    );
  }
}
