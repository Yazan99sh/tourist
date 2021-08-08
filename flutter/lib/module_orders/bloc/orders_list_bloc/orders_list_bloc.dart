import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/service/guide_orders/guide_orders.dart';
import 'package:tourists/module_orders/service/orders/orders_service.dart';
import 'package:tourists/module_orders/ui/screen/orders_list/order_list_screen.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state_error.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state_guide_order_loaded.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state_loading.dart';
import 'package:tourists/module_orders/ui/state/order_list/order_list_state_orders_loaded.dart';
import 'package:uuid/uuid.dart';

@provide
class OrdersListBloc {
  static const STATUS_CODE_INIT = 145;
  static const STATUS_CODE_LOADING = 175;
  static const STATUS_CODE_LOAD_SUCCESS = 155;
  static const STATUS_CODE_LOAD_ERROR = 165;

  final TouristOrdersService _ordersService;
  final GuideOrdersService _guideOrdersService;
  OrdersListBloc(this._ordersService, this._guideOrdersService);

  final _orderSubject = new PublishSubject<OrdersListState>();

  Stream<OrdersListState> get ordersStream => _orderSubject.stream;

  void getOrdersList(OrdersListScreen screen) {
    _orderSubject.add(OrderListStateLoading(screen));
    _ordersService.getOrders().then((value) {
      if (value == null) {
        _orderSubject.add(OrderListStateError(screen, 'Error Loading Data'));
      } else {
        _orderSubject.add(OrderListStateOrdersLoaded(screen, value));
      }
    });
  }

  void getGuidOrdersList(OrdersListScreen screen) {
    _orderSubject.add(OrderListStateLoading(screen));
    _guideOrdersService.getGuideOrders().then((value) {
      if (value == null) {
        _orderSubject.add(OrderListStateError(screen, 'Error Loading Data'));
      } else {
        _orderSubject.add(OrderListStateGuideOrdersLoaded(screen, value));
      }
    });
  }

  void payOrder(OrdersListScreen screen, OrderModel orderModel) {
    _orderSubject.add(OrderListStateLoading(screen));
    orderModel.roomId = Uuid().v1();
    _ordersService.updateOrder(orderModel).then((value) {
      if (value == null) {
        _orderSubject.add(OrderListStateError(screen, 'Error Loading Data'));
      } else {
        if (orderModel.status == 'done') {
          this.getGuidOrdersList(screen);
        } else {
          this.getOrdersList(screen);
        }
      }
    });
  }

  void dispose() {
    _orderSubject.close();
  }

  void refresh(OrdersListState state) {
    _orderSubject.add(state);
  }
}
