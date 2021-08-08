import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class TouristEPaymentScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TouristEPaymentScreenState();
}

class _TouristEPaymentScreenState extends State<TouristEPaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Text('${S.of(context).ccPay}!');
  }
}