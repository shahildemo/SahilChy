
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futsal_finder/models/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromFirestore(doc.data(), doc.id)).toList());
  }

  Future<void> deleteUser(String id) {
    return _db.collection('users').doc(id).delete();
  }
}
