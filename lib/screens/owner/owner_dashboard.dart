import 'package:flutter/material.dart';
import 'package:futsal_finder/screens/owner/owner_futsal_list_screen.dart';
import 'package:futsal_finder/screens/owner/owner_bookings_screen.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OwnerFutsalListScreen(),
                  ),
                );
              },
              child: const Text("My Futsal Fields"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OwnerBookingsScreen(),
                  ),
                );
              },
              child: const Text("View Bookings"),
            ),
          ],
        ),
      ),
    );
  }
}
