import 'package:flutter/material.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/view/widgets/calender_ui.dart';

class BookingScreens extends StatefulWidget {
  const BookingScreens({super.key});

  @override
  State<BookingScreens> createState() => _BookingScreensState();
}

class _BookingScreensState extends State<BookingScreens> {

  List<DateTime> _bookedDates = [];
  List<DateTime> _allBookedDates = [];
  PostingModel? _selectedPosting;


  List<DateTime> _getSelectedDates()
  {
    return [];
  }

  void _selectDates(DateTime date) 
  {

     
  }

  _selectPostings(PostingModel posting)
  {
    _selectedPosting = posting;
    _bookedDates = posting.getAllBookedDates();

    setState(() {
      
    });
  }

  _clearSelectedPosting()
  {
    _bookedDates = _allBookedDates;
    _selectedPosting = null;

    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookedDates = AppConstants.currentUser.getAllBookedDates();
    _allBookedDates = AppConstants.currentUser.getAllBookedDates()
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          children: [

            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Text('Sun'),
                Text('Mon'),
                Text('Tues'),
                Text('Wed'),
                Text('Thus'),
                Text('Fri'),
                Text('Sat'),
              ],
            ),

            Padding(
              padding: 
              const EdgeInsets.only(top: 15, bottom: 35),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: PageView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index)
                  {
                    return CalenderUi(
                      monthIndex: index,
                      bookedDates: ,
                    )
                  }),
              ),
              )
          ],
        ),
        )
    );
  }
}