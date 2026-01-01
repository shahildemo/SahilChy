import 'package:flutter/material.dart';
import 'package:futsal_finder/screens/owner/owner_bookings_screen.dart';
import 'package:futsal_finder/screens/owner/owner_futsal_list_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  OwnerHomeScreenState createState() => OwnerHomeScreenState();
}

class OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    OwnerFutsalListScreen(),
    OwnerBookingsScreen(),
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
            label: 'My Futsals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Bookings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
