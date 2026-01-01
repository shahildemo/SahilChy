import 'package:flutter/material.dart';
import 'package:futsal_finder/screens/booking/booking_history_screen.dart';
import 'package:futsal_finder/screens/home/futsal_list_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  UserHomeScreenState createState() => UserHomeScreenState();
}

class UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    FutsalListScreen(),
    BookingHistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Futsals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'My Bookings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
