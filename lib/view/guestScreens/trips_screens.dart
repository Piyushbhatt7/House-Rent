import 'package:flutter/material.dart';

class TripsScreens extends StatefulWidget {
  const TripsScreens({super.key});

  @override
  State<TripsScreens> createState() => _TripsScreensState();
}

class _TripsScreensState extends State<TripsScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore screen"),
      ),
    );
  }
}