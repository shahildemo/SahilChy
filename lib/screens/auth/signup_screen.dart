
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:futsal_finder/widgets/custom_button.dart';
import 'package:futsal_finder/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'User';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _displayNameController,
              labelText: "Display Name",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _emailController,
              labelText: "Email",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              labelText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: <String>['User', 'Futsal Owner']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Sign Up",
              onPressed: () async {
                final navigator = Navigator.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                try {
                  await authService.signUp(
                    _emailController.text,
                    _passwordController.text,
                    _displayNameController.text,
                    _selectedRole,
                  );
                  if (!mounted) return;
                  navigator.pop(); // Go back to the login screen
                } catch (e) {
                  if (!mounted) return;
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
