import 'package:flutter/material.dart';

class AmenitiesUi extends StatefulWidget {

  String type;
  int startValue;
  Function decreaseValue;
  Function increasesValue;

  AmenitiesUi({super.key, required this.type, required this.startValue, required this.decreaseValue, required this.increasesValue});

  @override
  State<AmenitiesUi> createState() => _AmenitiesUiState();
}

class _AmenitiesUiState extends State<AmenitiesUi> {

  int? _valueDigit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}