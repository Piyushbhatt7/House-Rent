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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          
        },
        items: items
        ),
    );
  }
}