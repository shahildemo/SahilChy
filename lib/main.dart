
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:futsal_finder/firebase_options.dart';
import 'package:futsal_finder/screens/auth/auth_wrapper.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:futsal_finder/services/futsal_service.dart';
import 'package:futsal_finder/services/user_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        Provider(create: (context) => UserService()),
        Provider(create: (context) => FutsalService()),
      ],
      child: MaterialApp(
        title: 'FutsalFinder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
