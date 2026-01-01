import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futsal_finder/models/booking.dart';

class BookingService {
  final CollectionReference _bookingCollection = FirebaseFirestore.instance.collection('bookings');

  Stream<List<Booking>> getBookingsForFutsal(String futsalId) {
    return _bookingCollection
        .where('futsalId', isEqualTo: futsalId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Booking.fromFirestore(doc)).toList();
    });
  }

  Stream<List<Booking>> getBookingsForFutsals(List<String> futsalIds) {
    return _bookingCollection
        .where('futsalId', whereIn: futsalIds)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Booking.fromFirestore(doc)).toList();
    });
  }

  Stream<List<Booking>> getBookingsForUser(String userId) {
    return _bookingCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Booking.fromFirestore(doc)).toList();
    });
  }

  Future<void> createBooking(Booking booking) {
    return _bookingCollection.add(booking.toFirestore());
  }
}
