import 'package:flutter/material.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/view/widgets/calender_ui.dart';


class BookListingScreen extends StatefulWidget
 {
  PostingModel? posting;

  
   BookListingScreen({super.key, this.posting});

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {

  PostingModel? posting;
  List<DateTime> bookedDates = [];
  List<DateTime> selectedDates = [];
  List<CalenderUi> calenderWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posting = widget.posting;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace:  Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Colors.pinkAccent,
        Colors.amberAccent
        ],
        begin: FractionalOffset(0, 0),
        end: FractionalOffset(1, 0),
        stops: [0, 1],
        tileMode: TileMode.clamp,
      )
    ),
      ),
        title: Text(
          "Book ${posting!.name}"
        ),
        
    ),
   
      body: Padding(padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           
           const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [

              // 17 - 2:26
              Text('Sun'),
              Text('Mon'),
              Text('Tues'),
              Text('Wed'),
              Text('Thus'),
              Text('Fri'),
              Text('Sat'),

            ],
           ),

           SizedBox(
            height: MediaQuery.of(context).size.height / 2,
           )
    
        ],
      ),
      ),
    );
  }
}