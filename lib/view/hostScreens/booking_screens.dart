import 'package:flutter/material.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/view/widgets/calender_ui.dart';
import 'package:house/view/widgets/posting_listinging_tile_ui.dart';

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

  _selectDates(DateTime date) 
  {

     
  }

  _selectAPosting(PostingModel posting)
  {
    _selectedPosting = posting;

    posting.getAllBookingsFromFirestore().whenComplete(()
    {
       _bookedDates = posting.getAllBookedDates();
    });

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
    _allBookedDates = AppConstants.currentUser.getAllBookedDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
      
              // calender UI
      
              Padding(
                padding: 
                const EdgeInsets.only(top: 15, bottom: 35),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: PageView.builder(
                    itemCount: 12,
                    itemBuilder: (context, index)
                    {
                      return CalenderUi(
                        monthIndex: index,
                        bookedDates: _bookedDates,
                        selectDates: _selectDates,
                        getSelectedDates: _getSelectedDates,
                      );
                    }),
                ),
                ),
      
               Padding(
                padding: 
               const EdgeInsets.fromLTRB(25, 25, 0, 25),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
      
                  const Text(
                    'Filter by Listing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
      
                  MaterialButton(
                    onPressed:()
                    {
                      _clearSelectedPosting();
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
      
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                      child: Container(),
                      ),
                ],
               ),
               ),
          
             // display  host listings
             ListView.builder(
              shrinkWrap: true,
              itemCount: AppConstants.currentUser.myPostings!.length,
              itemBuilder: 
              (context, index)
              {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 26.0),
                  child: InkResponse(
                    onTap: () {
                      _selectAPosting(AppConstants.currentUser.myPostings![index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedPosting == AppConstants.currentUser.myPostings![index] ? Colors.blue : Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: PostingListingingTileUI(
                        posting: AppConstants.currentUser.myPostings![index],
                      ),
                      // 9:38 - 20
                    ),
                  ),
                );
              })
          
            ],
          ),
          )
      ),
    );
  }
}