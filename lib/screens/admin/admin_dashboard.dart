import 'package:flutter/material.dart';
import 'package:futsal_finder/screens/admin/manage_users_screen.dart';
import 'package:futsal_finder/screens/admin/manage_futsals_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
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
                    builder: (context) => const ManageUsersScreen(),
                  ),
                );
              },
              child: const Text("Manage Users"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageFutsalsScreen(),
                  ),
                );
              },
              child: const Text("Manage Futsal Fields"),
            ),
          ],
        ),
      ),
    );
  }
}
