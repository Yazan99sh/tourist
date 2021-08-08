import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/repository/orders/orders.dart';
import 'package:tourists/module_orders/request/update_order_request.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';

@provide
class OrdersManager {
  final OrdersRepository _ordersRepository;

  OrdersManager(this._ordersRepository);

  Future<OrderListResponse> getGuideOrders(String userId) {
    return _ordersRepository.getGuideOrders(userId);
  }
  Future<OrderListResponse> getGuideOrdersList(String userId) {
    return _ordersRepository.getGuideOrdersList(userId);
  }
  Future<OrderListResponse> getTouristOrders(String userId) {
    return _ordersRepository.getTouristOrders(userId);
  }
  Future<OrderListResponse> getTouristOrdersPending(String userId) {
    return _ordersRepository.getTouristOrdersPending(userId);
  }

  Future<OrderListResponse> getGeneralOrderList(String guideId) {
    return _ordersRepository.getGeneralOrderList(guideId);
  }

  Future<UpdateOrderResponse> updateOrder(UpdateOrderRequest orderModel) {
    return _ordersRepository.updateOrder(orderModel);
  }

  Future<UpdateOrderResponse> updateAvailableOrder(UpdateOrderRequest orderModel) {
    return _ordersRepository.updateAvailableOrder(orderModel);
  }
}
