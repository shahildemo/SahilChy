import 'package:flutter/material.dart';
import 'package:futsal_finder/screens/user/my_bookings_screen.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${authService.user!.displayName}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text('Email: ${authService.user!.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBookingsScreen()),
                );
              },
              child: const Text('My Bookings'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authService.signOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
