import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_orders/bloc/guide_orders_list/guide_orders_list.dart';
import 'package:tourists/module_orders/bloc/orders_list_bloc/orders_list_bloc.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state_loading.dart';

@provide
class OrdersListScreen extends StatefulWidget {
  final OrdersListBloc _bloc;
  final AuthService _authService;
  final GuideOrdersListBloc guideBloc;
  OrdersListScreen(this._bloc, this._authService, this.guideBloc);

  @override
  State<StatefulWidget> createState() => _OrderListScreenState();

  void refresh(OrdersListState state) {
    _bloc.refresh(state);
  }

  void payOrder(OrderModel model) {
    _bloc.payOrder(this, model);
  }

  void refreshState() {
    _bloc.getGuidOrdersList(this);
  }
}

class _OrderListScreenState extends State<OrdersListScreen> {
  List<OrderModel> ordersList;
  OrdersListState currentStatus;
  Future<void> getCurrentStatus(OrdersListScreen screen) async {
    UserRole userRole = await widget._authService.userRole;
    if (userRole == UserRole.ROLE_TOURIST) {
      widget._bloc.getOrdersList(screen);
    } else {
      widget._bloc.getGuidOrdersList(screen);
    }
  }

  @override
  void initState() {
    getCurrentStatus(widget);
    widget._bloc.ordersStream.listen((event) {
      currentStatus = event;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentStatus ??= OrderListStateLoading(widget);
    return Scaffold(
      appBar: AppBar(
        title: Text('${S.of(context).orders}'),
      ),
      body: currentStatus.getUI(context) ?? Container(),
    );
  }
}
