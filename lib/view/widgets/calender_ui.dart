import 'package:flutter/material.dart';
import 'package:house/model/app_constants.dart';

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
  List<MonthTileWidget> _monthTiles = [];
  int? _currentMonthInt;
  int? _currentYearInt;

  _setMonthTiles()
  {
    _monthTiles = [];

    int daysInMonth = AppConstants.daysInMonths![_currentMonthInt]!;
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class MonthTileWidget extends StatelessWidget {
DateTime? dateTime;

   MonthTileWidget({super.key, this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime == null ? "" : dateTime!.day.toString(),
      style: const TextStyle(
        fontSize: 4
      ),
    );
  }
}