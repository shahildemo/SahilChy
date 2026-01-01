
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:futsal_finder/models/user_model.dart';
import 'package:futsal_finder/screens/admin/admin_dashboard.dart';
import 'package:futsal_finder/screens/auth/login_screen.dart';
import 'package:futsal_finder/screens/home/futsal_list_screen.dart';
import 'package:futsal_finder/screens/owner/owner_dashboard.dart';
import 'package:futsal_finder/services/auth_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<UserModel?>(
      stream: authService.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          if (user.role == 'Admin') {
            return const AdminDashboard();
          } else if (user.role == 'Futsal Owner') {
            return const OwnerDashboard();
          } else {
            return const FutsalListScreen();
          }
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
