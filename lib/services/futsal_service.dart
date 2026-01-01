
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futsal_finder/models/futsal.dart';

class FutsalService {
  final CollectionReference _futsalCollection = FirebaseFirestore.instance.collection('futsals');

  Stream<List<Futsal>> getFutsals() {
    return _futsalCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Futsal.fromFirestore(doc)).toList();
    });
  }

  Future<Futsal?> getFutsalById(String id) async {
    final doc = await _futsalCollection.doc(id).get();
    if (doc.exists) {
      return Futsal.fromFirestore(doc);
    } else {
      return null;
    }
  }

  Stream<List<Futsal>> getFutsalsByIds(List<String> ids) {
    return _futsalCollection.where(FieldPath.documentId, whereIn: ids).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Futsal.fromFirestore(doc)).toList();
    });
  }

  Stream<List<Futsal>> getFutsalsByOwner(String ownerId) {
    return _futsalCollection.where('ownerId', isEqualTo: ownerId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Futsal.fromFirestore(doc)).toList();
    });
  }

  Future<void> addFutsal(Futsal futsal) {
    return _futsalCollection.add(futsal.toFirestore());
  }

  Future<void> deleteFutsal(String id) {
    return _futsalCollection.doc(id).delete();
  }
}
