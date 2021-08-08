import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_forms/user_orders_module/response/order/order_response.dart';
import 'package:tourists/module_orders/manager/orders/orders_manager.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/request/update_order_request.dart';
import 'package:tourists/module_orders/response/update_order_response.dart';

@provide
class TouristOrdersService {
  final OrdersManager _ordersManager;
  final AuthService _authService;

  TouristOrdersService(
    this._ordersManager,
    this._authService,
  );

  Future<List<OrderModel>> getOrders() async {
    String uid = await _authService.userID;
    if (uid == null) {
      return null;
    }
    if (await _authService.getToken() == null ||
        !await _authService.isLoggedIn) {
      return null;
    }
    var orders = await _ordersManager.getTouristOrders(uid);
    var orders2 = await _ordersManager.getTouristOrdersPending(uid);

    if (orders?.data == null && orders2?.data == null) {
      return [];
    }

    List allOrder = [];
    if (orders != null) {
      allOrder.addAll(orders.data);
    }
    if (orders2 != null) {
      allOrder.addAll(orders2.data);
    }
    if (allOrder.isEmpty) {
      return [];
    }
    return allOrder
        .map((e) => OrderModel(
              id: e.id,
              touristId: e.touristUserID,
              guideUserID: e.guidUserID,
              language: e.language ?? e.order.language,
              services: e.services,
              city: e.city ?? e.order.city,
              cost: e.cost,
              roomId: e.roomID ?? e.uuid,
              status: e.status,
              arriveDate: e.arriveDate?.timestamp == null
                  ? DateTime.now()
                  : DateTime.fromMillisecondsSinceEpoch(
                      1000 * e.arriveDate?.timestamp),
              leaveDate: e.leaveDate?.timestamp == null
                  ? DateTime.now()
                  : DateTime.fromMillisecondsSinceEpoch(
                      1000 * e.leaveDate?.timestamp),
              date: e.arriveDate?.timestamp == null
                  ? DateTime.now()
                  : DateTime.fromMillisecondsSinceEpoch(
                      1000 * e.date?.timestamp),
            ))
        .toList();
  }
  Future<List<OrderModel>> getGuideOrderList() async {
    String uid = await _authService.userID;
    if (uid == null) {
      return null;
    }
    if (await _authService.getToken() == null ||
        !await _authService.isLoggedIn) {
      return null;
    }
    var orders = await _ordersManager.getGuideOrdersList(uid);

    if (orders?.data == null) {
      return [];
    }

    List allOrder = [];
    if (orders != null) {
      allOrder.addAll(orders.data);
    }
    if (allOrder.isEmpty) {
      return [];
    }
    return allOrder
        .map((e) => OrderModel(
              id: e.id,
              touristId: e.touristUserID,
              guideUserID: e.guidUserID,
              language: e.language ?? e.order.language,
              services: e.services,
              city: e.city ?? e.order.city,
              cost: e.cost,
              roomId: e.roomID ?? e.uuid,
              status: e.status,
              arriveDate: e.arriveDate?.timestamp == null
                  ? DateTime.now()
                  : DateTime.fromMillisecondsSinceEpoch(
                      1000 * e.arriveDate?.timestamp),
              leaveDate: e.leaveDate?.timestamp == null
                  ? DateTime.now()
                  : DateTime.fromMillisecondsSinceEpoch(
                      1000 * e.leaveDate?.timestamp),
              date: e.arriveDate?.timestamp == null
                  ? DateTime.now()
                  : DateTime.fromMillisecondsSinceEpoch(
                      1000 * e.date?.timestamp),
            ))
        .toList();
  }

  Future<List<OrderModel>> getGeneralOrders() async {
    String uid = await _authService.userID;

    OrderListResponse response = await _ordersManager.getGeneralOrderList(uid);

    if (response != null) {
      return response.data
          .map((e) => OrderModel(
                id: e.id,
                touristId: e.touristUserID,
                guideUserID: e.guidUserID,
                language: e.language ?? e.order.language,
                services: e.services,
                arriveDate: e.arriveDate == null
                    ? DateTime.now()
                    : DateTime.fromMillisecondsSinceEpoch(
                        1000 * e.arriveDate?.timestamp),
                leaveDate: e.leaveDate == null
                    ? DateTime.now()
                    : DateTime.fromMillisecondsSinceEpoch(
                        1000 * e.leaveDate?.timestamp),
                date: e.date == null
                    ? DateTime.now()
                    : DateTime.fromMillisecondsSinceEpoch(
                        1000 * e.date?.timestamp),
                city: e.city ?? e.order.city,
                cost: e.cost,
                roomId: e.roomID ?? e.uuid,
                status: e.status,
              ))
          .toList();
    }
    return null;
  }

  Future<UpdateOrderResponse> updateOrder(OrderModel orderModel) async {
    UpdateOrderResponse response = await _ordersManager.updateOrder(
      _toUpdateOrderRequest(orderModel),
    );

    if (response == null) {
      return null;
    }

    return response;
  }

  UpdateOrderRequest _toUpdateOrderRequest(OrderModel orderModel) {
    if (orderModel.touristId == null) {
      return UpdateOrderRequest(status: orderModel.status, id: orderModel.id);
    } else {
      return UpdateOrderRequest(
          status: 'onGoing',
          services: orderModel.services,
          touristUserID: orderModel.touristId,
          guidUserID: FirebaseAuth.instance.currentUser.uid,
          cost: int.tryParse(orderModel.cost) ?? 0,
          city: orderModel.city,
          language: orderModel.language,
          date: DateTime.now().toIso8601String(),
          arriveDate: orderModel.arriveDate.toIso8601String(),
          leaveDate: orderModel.leaveDate.toIso8601String(),
          orderID: orderModel.id.toString());
    }
  }
}
