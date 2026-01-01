import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futsal_finder/models/user_model.dart';
import 'package:futsal_finder/screens/auth/auth_wrapper.dart';
import 'package:futsal_finder/screens/home/futsal_list_screen.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'mock.dart';

class MockAuthService extends Mock implements AuthService {
  final BehaviorSubject<UserModel?> _user = BehaviorSubject<UserModel?>();

  @override
  Stream<UserModel?> get userStream => _user.stream;

  
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _user.add(UserModel(uid: '1234', email: email, displayName: 'Test User', role: 'User'));
  }

  @override
  Future<void> signOut() async {
    _user.add(null);
  }
}

void main() {
  setUpAll(() {
    setupFirebaseCoreMocks();
  });

  testWidgets('AuthWrapper shows FutsalListScreen after login', (WidgetTester tester) async {
    final authService = MockAuthService();

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthService>(
        create: (_) => authService,
        child: const MaterialApp(
          home: AuthWrapper(),
        ),
      ),
    );

    // Initially, no user is logged in, so we should see the login screen.
    expect(find.byType(FutsalListScreen), findsNothing);

    // Simulate a login
    await authService.signInWithEmailAndPassword('test@test.com', 'password');
    await tester.pump();

    // After login, we should see the FutsalListScreen.
    expect(find.byType(FutsalListScreen), findsOneWidget);

    // Simulate a signout
    await authService.signOut();
    await tester.pump();

    // After signout, we should not see the FutsalListScreen.
    expect(find.byType(FutsalListScreen), findsNothing);
  });
}
