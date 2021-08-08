import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel orderModel;
  final Function(OrderModel) onAcceptOrder;
  final Function(OrderModel) onAcceptAvailableOrder;
  final Function(OrderModel) onPayOrder;
  final Function(OrderModel) onPayAvailableOrder;
  final bool canPay;

  OrderItemWidget(this.orderModel,
      {this.onAcceptOrder,
      this.onPayAvailableOrder,
      this.onAcceptAvailableOrder,
      this.onPayOrder,
      this.canPay = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _getPendingOrder(orderModel, context),
        ),
      ),
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
                      '${S.of(context).pending}',
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
}
