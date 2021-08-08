import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/repository/guide_orders/guide_orders.dart';
import 'package:tourists/module_orders/request/update_order_request.dart';
import 'package:tourists/module_orders/response/order_lookup_response.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';

@provide
class GuideOrdersManager {
  final GuideOrdersRepository _repository;
  GuideOrdersManager(this._repository);

  Future<OrderLookupResponse> getAvailableOrders() {
    return _repository.getAvailableOrders();
  }

  Future<OrderListResponse> getGuideOrders(String guideUserId) {
    return _repository.getGuideOrders(guideUserId);
  }

  Future<UpdateOrderResponse> updateOrder(UpdateOrderRequest orderModel) {
    return _repository.updateOrder(orderModel);
  }

  Future<UpdateOrderResponse> updateAvailableOrder(UpdateOrderRequest orderModel) {
    return _repository.updateAvailableOrder(orderModel);
  }

  Future<OrderListResponse> getLookupOrder(String guideUserId) {
    return _repository.getLookupOrder(guideUserId);
  }
}
