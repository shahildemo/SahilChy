import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

// A mock implementation of [FirebasePlatform] to be used in tests.
//
// This is a simplified version of the mock from the firebase_core tests.
class MockFirebaseCore extends FirebasePlatform {
  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    return MockFirebaseApp();
  }

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return MockFirebaseApp();
  }
}

class MockFirebaseApp extends FirebaseAppPlatform {
  MockFirebaseApp() : super('[DEFAULT]', const FirebaseOptions(
        apiKey: 'mock_api_key',
        appId: 'mock_app_id',
        messagingSenderId: 'mock_messaging_sender_id',
        projectId: 'mock_project_id',
      ));

  // Other properties and methods can be mocked as needed.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void setupFirebaseCoreMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FirebasePlatform.instance = MockFirebaseCore();
}
