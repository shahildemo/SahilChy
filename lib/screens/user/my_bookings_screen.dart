import 'package:flutter/material.dart';
import 'package:futsal_finder/models/booking.dart';
import 'package:futsal_finder/models/futsal.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:futsal_finder/services/booking_service.dart';
import 'package:futsal_finder/services/futsal_service.dart';
import 'package:provider/provider.dart';

class MyBookingsScreen extends StatelessWidget {
  final BookingService _bookingService = BookingService();
  final FutsalService _futsalService = FutsalService();

  MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: StreamBuilder<List<Booking>>(
        stream: _bookingService.getBookingsForUser(authService.user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('You have no bookings.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final booking = snapshot.data![index];
              return FutureBuilder<Futsal?>(
                future: _futsalService.getFutsalById(booking.futsalId),
                builder: (context, futsalSnapshot) {
                  if (futsalSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Loading futsal name...'),
                    );
                  }
                  return ListTile(
                    title: Text(futsalSnapshot.data?.name ?? 'Futsal not found'),
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
