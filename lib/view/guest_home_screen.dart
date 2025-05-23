import 'package:flutter/material.dart';
import 'package:house/view/guestScreens/account_screen.dart';
import 'package:house/view/guestScreens/explore_screen.dart';
import 'package:house/view/guestScreens/inbox_screen.dart';
import 'package:house/view/guestScreens/saved_listings_screen.dart';
import 'package:house/view/guestScreens/trips_screens.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {

  int selectedIndex = 0;

  final List<String> screenTitles = [
    'Explore',
    'Saved',
    'Trips',
    'Inbox',
    'Profile',
  ];

  final List<Widget> screens = [
    ExploreScreen(),
    SavedListingsScreen(),
    TripsScreens(),
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
          customNavigationBarItem(0, Icons.search_outlined, screenTitles[0]),
          customNavigationBarItem(1, Icons.favorite_border_outlined, screenTitles[1]),
          customNavigationBarItem(2, Icons.hotel_outlined, screenTitles[2]),
          customNavigationBarItem(3, Icons.message_outlined, screenTitles[3]),
          customNavigationBarItem(4, Icons.person_outlined, screenTitles[4]),// 11:44 - 7
        ]
        ),
    );
  }
} 