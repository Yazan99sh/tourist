import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/manager/guide_orders/guide_orders.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/request/update_order_request.dart';
import 'package:tourists/module_orders/response/order_lookup_response.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';
import 'package:uuid/uuid.dart';

@provide
class GuideOrdersService {
  final GuideOrdersManager _ordersManager;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GuideOrdersService(this._ordersManager);

  Future<List<OrderModel>> getAvailableOrders() async {
    OrderLookupResponse response = await _ordersManager.getAvailableOrders();

    if (response == null) {
      return [];
    }

    return response.data.map((e) {
      return OrderModel(
        id: e.id,
        leaveDate:
            DateTime.fromMillisecondsSinceEpoch(1000 * e.leaveDate.timestamp),
        arriveDate:
            DateTime.fromMillisecondsSinceEpoch(1000 * e.arriveDate.timestamp),
        touristId: e.touristUserID,
        status: e.status,
        services: e.services,
        cost: e.cost,
        language: e.language,
        city: e.city,
      );
    }).toList();
  }

  Future<List<OrderModel>> getGuideOrders() async {
    User user = await _auth.currentUser;
    String userId = user.uid;

    OrderListResponse response = await _ordersManager.getGuideOrders(userId);
    OrderListResponse response2 = await _ordersManager.getLookupOrder(userId);

    if (response == null && response2 == null) {
      return <OrderModel>[];
    }
    List lookupOrder = response2 != null ? response2.data : null;
    List guideOrder = response != null ? response.data : null;
    List allOrder = [];
    if (lookupOrder != null) {
      allOrder.addAll(lookupOrder);
    }

    if (guideOrder != null) {
      allOrder.addAll(guideOrder);
    }
    return allOrder.map((e) {
      if (e.order != null) {
        return OrderModel(
          id: e.id,
          touristId: e.order.touristUserID,
          guideUserID: e.order.guidUserID,
          language: e.order.language,
          services: e.order.services,
          arriveDate: DateTime.fromMillisecondsSinceEpoch(
              1000 * e.order.arriveDate.timestamp),
          leaveDate: DateTime.fromMillisecondsSinceEpoch(
              1000 * e.order.leaveDate.timestamp),
          date: DateTime.fromMillisecondsSinceEpoch(
              1000 * e.order.date.timestamp),
          city: e.order.city,
          cost: e.cost,
          roomId: e.order.roomID??e.order.uuid??e.uuid,
          status: e.status,
        );
      }
      return OrderModel(
        id: e.id,
        touristId: e.touristUserID,
        guideUserID: e.guidUserID,
        language: e.language,
        services: e.services,
        arriveDate:
            DateTime.fromMillisecondsSinceEpoch(1000 * e.arriveDate.timestamp),
        leaveDate:
            DateTime.fromMillisecondsSinceEpoch(1000 * e.leaveDate.timestamp),
        date: DateTime.fromMillisecondsSinceEpoch(1000 * e.date.timestamp),
        city: e.city,
        cost: e.cost,
        roomId: e.roomID??e.uuid,
        status: e.status,
      );
    }).toList();
  }
  Future<List<OrderModel>> getGuideArea() async {
    User user = await _auth.currentUser;
    String userId = user.uid;

    OrderListResponse response = await _ordersManager.getGuideOrders(userId);

    List guideOrder = response != null ? response.data : null;
    List allOrder = [];

    if (guideOrder != null) {
      allOrder.addAll(guideOrder);
    }
    return allOrder.map((e) {
      if (e.order != null) {
        return OrderModel(
          id: e.id,
          touristId: e.order.touristUserID,
          guideUserID: e.order.guidUserID,
          language: e.order.language,
          services: e.order.services,
          arriveDate: DateTime.fromMillisecondsSinceEpoch(
              1000 * e.order.arriveDate.timestamp),
          leaveDate: DateTime.fromMillisecondsSinceEpoch(
              1000 * e.order.leaveDate.timestamp),
          date: DateTime.fromMillisecondsSinceEpoch(
              1000 * e.order.date.timestamp),
          city: e.order.city,
          cost: e.cost,
          roomId: e.order.roomID??e.order.uuid??e.uuid,
          status: e.status,
        );
      }
      return OrderModel(
        id: e.id,
        touristId: e.touristUserID,
        guideUserID: e.guidUserID,
        language: e.language,
        services: e.services,
        arriveDate:
            DateTime.fromMillisecondsSinceEpoch(1000 * e.arriveDate.timestamp),
        leaveDate:
            DateTime.fromMillisecondsSinceEpoch(1000 * e.leaveDate.timestamp),
        date: DateTime.fromMillisecondsSinceEpoch(1000 * e.date.timestamp),
        city: e.city,
        cost: e.cost,
        roomId: e.roomID??e.uuid,
        status: e.status,
      );
    }).toList();
  }

  Future<List<OrderModel>> getAllPossibleOrders() async {
    List<OrderModel> guideOrders = [];
    List<OrderModel> locationOrders = await getAvailableOrders();

    List<OrderModel> allOrders = [];
    allOrders.addAll(guideOrders);
    var existingOrders = <int>{};
    allOrders.forEach((element) {
      existingOrders.add(element.id);
    });
    allOrders.addAll(
        locationOrders.where((element) => !allOrders.contains(element.id)));
    print('Location Order: ${locationOrders.length}');

    return allOrders;
  }

  Future<UpdateOrderResponse> acceptOrder(OrderModel orderModel) async {
    UpdateOrderResponse response =
        await _ordersManager.updateOrder(_toUpdateOrderRequest(orderModel));

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> acceptAvailableOrder(
      OrderModel orderModel) async {
    orderModel.roomId = new Uuid().v1();
    orderModel.status = 'pendingPayment';

    User user = await _auth.currentUser;
    orderModel.guideUserID = user.uid;

    UpdateOrderResponse response = await _ordersManager
        .updateAvailableOrder(_toUpdateOrderRequest(orderModel));

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> payOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response =
        await _ordersManager.updateOrder(_toUpdateOrderRequest(orderModel));

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> payAvailableOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response =
        await _ordersManager.updateOrder(_toUpdateOrderRequest(orderModel));

    if (response == null) {
      return null;
    }

    return response;
  }

  Future<UpdateOrderResponse> startAvailableOrder(OrderModel orderModel) async {
    orderModel.status = 'onGoing';

    UpdateOrderResponse response =
        await _ordersManager.updateOrder(_toUpdateOrderRequest(orderModel));

    if (response == null) {
      return null;
    }

    return response;
  }

  UpdateOrderRequest _toUpdateOrderRequest(OrderModel orderModel) {
    return UpdateOrderRequest(
      status: orderModel.status,
      roomID: new Uuid().v1(),
      services: orderModel.services,
      touristUserID: orderModel.touristId,
      guidUserID: FirebaseAuth.instance.currentUser.uid,
      cost: int.tryParse(orderModel.cost),
      city: orderModel.city,
      language: orderModel.language,
      date: DateTime.now().toIso8601String(),
      arriveDate: orderModel.arriveDate.toIso8601String(),
      leaveDate: orderModel.leaveDate.toIso8601String(),
      orderID: orderModel.id.toString(),
    );
  }
}
