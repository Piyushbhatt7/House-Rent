import 'package:flutter/material.dart';
import 'package:house/view/guestScreens/account_screen.dart';
import 'package:house/view/guestScreens/inbox_screen.dart';
import 'package:house/view/hostScreens/booking_screens.dart';
import 'package:house/view/hostScreens/my_posting_screen.dart';

class HostHomeScreen extends StatefulWidget {

  int? index;
  HostHomeScreen({super.key, this.index});

  @override
  State<HostHomeScreen> createState() => _HostHomeScreenState();
}

class _HostHomeScreenState extends State<HostHomeScreen> {

  int selectedIndex = 0;

  final List<String> screenTitles = [
    'Booking',
    'My Posting',
    'Inbox',
    'Profile',
    
  ];

  final List<Widget> screens = [
    BookingScreens(),
    MyPostingScreen(),
    InboxScreen(),
    AccountScreen(),
  ];

  BottomNavigationBarItem customNavigationBarItem(int index, IconData iconData, String title)
  {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: Colors.black,),
      activeIcon: Icon(iconData, color: Colors.blueAccent,),
      label: title,
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedIndex = widget.index ?? 3;  
  }

  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar:AppBar( 
        flexibleSpace: Container( 
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
          screenTitles[selectedIndex],
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ) ,
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) 
        {
          setState(() {
            selectedIndex = i;
          }); 
        },
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>
        [
          customNavigationBarItem(0, Icons.calendar_today_outlined, screenTitles[0]),
          customNavigationBarItem(1, Icons.home_filled, screenTitles[1]),
          customNavigationBarItem(3, Icons.message_outlined, screenTitles[2]),
          customNavigationBarItem(4, Icons.person_outlined, screenTitles[3]),// 11:44 - 7
        ]
        ),
    );
  }
} 