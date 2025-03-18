import 'package:flutter/material.dart';

class CalenderUi extends StatefulWidget {

  int? monthIndex;
  List<DateTime>? bookedDates;
  Function? selectDates;
  Function? getSelectedDates;

  CalenderUi({super.key, this.monthIndex, this.bookedDates, this.selectDates, this.getSelectedDates});

  @override
  State<CalenderUi> createState() => _CalenderUiState();
}

class _CalenderUiState extends State<CalenderUi> {


  List<DateTime> _selectedDates = [];
  List<> _monthTiles = [];
  int? _currentMonthInt;
  int? _currentYearInt;


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


