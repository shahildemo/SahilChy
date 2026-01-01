import 'package:flutter/material.dart';
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
            const SizedBox(height: 8.0),
            Text('Role: ${authService.user!.role}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await authService.signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
