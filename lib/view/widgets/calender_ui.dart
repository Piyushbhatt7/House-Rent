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

    DateTime firstDaysOfMonth = DateTime(_currentYearInt!, _currentMonthInt!, 1);

    int firstWeekOfMonth = firstDaysOfMonth.weekday;

    if(firstWeekOfMonth != 7)
    {
      for(int i = 0; i < firstWeekOfMonth; i++)
      {
        _monthTiles.add(MonthTileWidget(dateTime: null,));
      }

    }

    for(int i = 1; i <= daysInMonth; i++)
    {
      DateTime date = DateTime(_currentYearInt!, _currentMonthInt!, 1);
      _monthTiles.add(MonthTileWidget(dateTime: date,));
    }
  }

  _selectDates(DateTime date)
  {
    if(_selectedDates.contains(date))
    {
      _selectedDates.remove(date);
    }

    else {
      _selectedDates.add(date);
    }

    widget.selectDates!(date);

    setState(() {
      
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _currentMonthInt = (DateTime.now().month + widget.monthIndex!) % 12;

    if(_currentMonthInt == 0)
    {
      _currentMonthInt = 12;
    }

    _currentYearInt = DateTime.now().year;

    if(_currentMonthInt! < DateTime.now().month)
    {
      _currentYearInt = _currentYearInt! + 1;
    }

    _selectedDates.sort();

    _selectedDates.addAll(widget.getSelectedDates!());

    _setMonthTiles();
  } 


  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(padding: const EdgeInsets.only(bottom: 20.0),
        child: Text(
          "${AppConstants.monthDict[_currentMonthInt]} - ${_currentYearInt}",

        ),
        ),

        GridView.builder(
          itemCount: _monthTiles.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7,
          childAspectRatio: 1 / 1
          ),

          itemBuilder: (context, index) {
            
          },

        )
      ],
    );
  }
}




//////////////////////////////////////////
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