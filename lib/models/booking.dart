import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String futsalId;
  final String userId;
  final DateTime date;
  final String time;
  final String status;

  Booking({
    required this.id,
    required this.futsalId,
    required this.userId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Booking.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Booking(
      id: doc.id,
      futsalId: data['futsalId'] ?? '',
      userId: data['userId'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'] ?? '',
      status: data['status'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'futsalId': futsalId,
      'userId': userId,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}
