import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_chat/chat_routes.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel orderModel;
  final Function(OrderModel) onAcceptOrder;
  final Function(OrderModel) onAcceptAvailableOrder;
  final Function(OrderModel) onPayOrder;
  final Function(OrderModel) onPayAvailableOrder;
  final bool canPay;
  final String status;

  OrderItemWidget(this.orderModel,
      {this.onAcceptOrder,
      this.onPayAvailableOrder,
      this.onAcceptAvailableOrder,
      this.onPayOrder,
      this.canPay = false,
      this.status});

  @override
  Widget build(BuildContext context) {
    // This will be the children of the flex
    List<Widget> widgetLayout = [];

    // If there is guide assigned, Show Multiple Choices
    if (orderModel.guideUserID != null) {
      if (orderModel.status == 'pending') {
        widgetLayout.add(_getPendingOrder(orderModel, context));
      } else if (orderModel.status == 'onGoing') {
        // There is a chat here
        widgetLayout.add(_getOnGoingOrder(orderModel, context));
      } else if (orderModel.status == 'pendingPayment') {
        // There is a chat here
        widgetLayout.add(_getPendingPaymentOrder(orderModel, context));
      } else if (orderModel.status == 'finished' ||
          orderModel.status == 'done') {
        widgetLayout.add(_getFinishedOrder(orderModel, context));
      }
    } else {
      widgetLayout.add(_getAvailableOrder(orderModel, context));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.vertical,
            children: widgetLayout,
          ),
        ),
      ),
    );
  }

  Widget _getAvailableOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(),
                child: Image.asset('resources/images/logo.jpg'),
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).request_for_guide,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 8,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(orderModel.city),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('|'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(orderModel.language),
                        )
                      ],
                    ),
                    Container(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            // Order date
            Flexible(
                child: Text(orderModel.date
                    .toIso8601String()
                    .toString()
                    .substring(5, 10)))
          ],
        ),
        RaisedButton(
          onPressed: () {
            onAcceptAvailableOrder(orderModel);
          },
          child: Text(S.of(context).accept_order),
        )
      ],
    );
  }

  Widget _getPendingOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                  height: 72,
                  width: 72,
                  alignment: Alignment.center,
//                  decoration: BoxDecoration(color: Colors.greenAccent),
                  child: Image.asset(
                    'resources/images/logo.jpg',
                    fit: BoxFit.contain,
                  )),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${S.of(context).order} #${orderModel.id} ${S.of(context).pending}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 8,
                    ),
                    Text(
                        '${orderModel.city ?? ''} | ${orderModel.language ?? ''}'),
                    Container(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            // Order date
            Flexible(child: Text(orderModel.date.toString().substring(5, 10)))
          ],
        ),
        canPay != null && canPay
            ? RaisedButton(
                onPressed: () {
                  this.onAcceptOrder(orderModel);
                },
                child: Text(S.of(context).accept_order),
              )
            : Container()
      ],
    );
  }

  Widget _getPendingPaymentOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                  height: 72,
                  width: 72,
                  alignment: Alignment.center,
//                  decoration: BoxDecoration(color: Colors.greenAccent),
                  child: Image.asset(
                    'resources/images/logo.jpg',
                    fit: BoxFit.contain,
                  )),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${S.of(context).order} #${orderModel.id} ${S.of(context).pending}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 8,
                    ),
                    Text(
                        '${S.of(context).city} ${orderModel.city ?? ''} | ${S.of(context).language} ${orderModel.language ?? ''} | ${S.of(context).cost} ${orderModel.cost ?? ''}'),
                    Container(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            // Order date
            Flexible(child: Text(orderModel.date.toString().substring(5, 10)))
          ],
        ),
        canPay != null && canPay
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    onPressed: () {
                      OrderModel order =
                          OrderModel(id: orderModel.id, status: 'onGoing');
                      orderModel.status = 'onGoing';
                      this.onAcceptOrder(order);
                    },
                    child: Text(S.of(context).accept_order),
                  ),
                  RaisedButton(
                    onPressed: () {
                      orderModel.status = 'refused';
                      OrderModel order =
                          OrderModel(id: orderModel.id, status: 'refused');
                      this.onAcceptOrder(order);
                    },
                    child: Text('${S.of(context).refused}'),
                  ),
                ],
              )
            : Container()
      ],
    );
  }

  Widget _getOnGoingOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                  height: 72,
                  width: 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.greenAccent),
                  child: Image.asset(
                    'resources/images/logo.jpg',
                    fit: BoxFit.contain,
                  )),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${S.of(context).order} #${orderModel.id} ${S.of(context).pending}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 8,
                    ),
                    Text(
                      '${S.of(context).onGoing}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            // Order date
            Flexible(child: Text(orderModel.date.toString().substring(5, 10)))
          ],
        ),
        RaisedButton(
          child: Text(S.of(context).openChat),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(ChatRoutes.chatRoute, arguments: orderModel.roomId);
          },
        ),
        canPay != null && canPay && status != null
            ? RaisedButton(
                child: Text('${S.of(context).finishOrder}'),
                onPressed: () {
                  OrderModel order =
                      OrderModel(id: orderModel.id, status: status ?? 'done');
                  this.onAcceptOrder(order);
                },
              )
            : Container()
      ],
    );
  }

  Widget _getFinishedOrder(OrderModel orderModel, BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
              height: 72,
              width: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Image.asset(
                'resources/images/logo.jpg',
                fit: BoxFit.contain,
              )),
        ),
        Flexible(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${S.of(context).finished}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 8,
                ),
                Text(orderModel.city + ' | ' + orderModel.language),
                Container(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        // Order date
        Flexible(
            flex: 1, child: Text(orderModel.date.toString().substring(5, 10)))
      ],
    );
  }
}
