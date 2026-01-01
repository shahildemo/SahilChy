
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futsal_finder/models/user_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String displayName, String email, String role) async {
    return await userCollection.doc(uid).set({
      'displayName': displayName,
      'email': email,
      'role': role,
    });
  }

  UserModel _userFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: uid!,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
    );
  }

  Stream<UserModel> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }
}
