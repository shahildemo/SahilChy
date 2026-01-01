import 'package:flutter/material.dart';
import 'package:futsal_finder/models/booking.dart';
import 'package:futsal_finder/models/futsal.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:futsal_finder/services/booking_service.dart';
import 'package:futsal_finder/services/futsal_service.dart';
import 'package:provider/provider.dart';

class OwnerBookingsScreen extends StatelessWidget {
  final FutsalService _futsalService = FutsalService();
  final BookingService _bookingService = BookingService();

   OwnerBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: StreamBuilder<List<Futsal>>(
        stream: _futsalService.getFutsalsByOwner(authService.user!.uid),
        builder: (context, futsalSnapshot) {
          if (futsalSnapshot.hasError) {
            return Center(child: Text('Error: ${futsalSnapshot.error}'));
          }
          if (futsalSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final futsalIds = futsalSnapshot.data!.map((futsal) => futsal.id).whereType<String>().toList();
          return StreamBuilder<List<Booking>>(
            stream: _bookingService.getBookingsForFutsals(futsalIds),
            builder: (context, bookingSnapshot) {
              if (bookingSnapshot.hasError) {
                return Center(child: Text('Error: ${bookingSnapshot.error}'));
              }
              if (bookingSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (bookingSnapshot.data!.isEmpty) {
                return const Center(child: Text('You have no bookings.'));
              }
              return ListView.builder(
                itemCount: bookingSnapshot.data!.length,
                itemBuilder: (context, index) {
                  final booking = bookingSnapshot.data![index];
                  return ListTile(
                    title: Text('Futsal ID: ${booking.futsalId}'),
                    subtitle: Text('${booking.date.toLocal()} at ${booking.time}'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
