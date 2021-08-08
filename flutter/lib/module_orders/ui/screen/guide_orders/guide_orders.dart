import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_orders/bloc/guide_orders_list/guide_orders_list.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/ui/widget/guide_order_item/guide_order_item.dart';

@provide
class GuideOrdersScreen extends StatefulWidget {
  final GuideOrdersListBloc bloc;
  final FirebaseAuth auth = FirebaseAuth.instance;

  GuideOrdersScreen(this.bloc);

  @override
  State<StatefulWidget> createState() => _GuideOrdersScreenState();
}

class _GuideOrdersScreenState extends State<GuideOrdersScreen> {
  int activeList = 0;
  int currentStatus = GuideOrdersListBloc.STATUS_CODE_INIT;
  List<OrderModel> ordersList;

  @override
  Widget build(BuildContext context) {
    widget.bloc.stateStream.listen((event) {
      currentStatus = event[GuideOrdersListBloc.KEY_STATUS];

      if (currentStatus == GuideOrdersListBloc.STATUS_CODE_LOAD_SUCCESS) {
        ordersList = event[GuideOrdersListBloc.KEY_PAYLOAD];
      }

      if (this.mounted) setState(() {});
    });

    switch (currentStatus) {
      case GuideOrdersListBloc.STATUS_CODE_LOADING:
        return _getLoadingUI();
      case GuideOrdersListBloc.STATUS_CODE_LOAD_SUCCESS:
        return _getSuccessUI();
      case GuideOrdersListBloc.STATUS_CODE_INIT:
        widget.bloc.getAvailableOrders();
        return _getLoadingUI();
      case GuideOrdersListBloc.STATUS_CODE_ORDER_UPDATED:
        widget.bloc.getAvailableOrders();
        return _getLoadingUI();
      default:
        return _getErrorScreen();
    }
  }

  Widget _getSuccessUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).orders),
      ),
      body: PageView(
        children: <Widget>[
          FutureBuilder(
            future: _getAvailableOrders(),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _getLoadingUI() {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: CircularProgressIndicator()),
          Text(
            S.of(context).loading,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _getErrorScreen() {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).error_fetching_data,
            textAlign: TextAlign.center,
          ),
          RaisedButton(
            onPressed: () {
              widget.bloc.getAvailableOrders();
            },
            child: Text(S.of(context).reload),
          )
        ],
      ),
    );
  }

  Future<Widget> _getAvailableOrders() async {
    List<Widget> orderCards = [];

    if (ordersList != null) {
      ordersList.forEach((order) {
        orderCards.add(GuideOrderItemWidget(
          order,
          onAcceptOrder: (order) {
            print('Accept Order');
            widget.bloc.acceptOrder(order);
          },
          onAcceptAvailableOrder: (order) {
            print('Accept Available Order');
            widget.bloc.acceptAvailableOrder(order);
          },
          onPayOrder: (order) {
            print('Pay Order');
            widget.bloc.payOrder(order);
          },
          onPayAvailableOrder: (orderModel) {
            print('Pay available Order');
            widget.bloc.payAvailableOrder(orderModel);
          },
        ));
      });
    }

    return ListView(
      children: orderCards,
    );
  }
}
