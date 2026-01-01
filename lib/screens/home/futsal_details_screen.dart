import 'package:flutter/material.dart';
import 'package:futsal_finder/models/futsal.dart';
import 'package:futsal_finder/screens/booking/booking_screen.dart';

class FutsalDetailsScreen extends StatelessWidget {
  final Futsal futsal;

  const FutsalDetailsScreen({super.key, required this.futsal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(futsal.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              futsal.imageUrls.isNotEmpty ? futsal.imageUrls[0] : 'https://via.placeholder.com/150',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text(futsal.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(futsal.location, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text('\$${futsal.price}/hour', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),
            Text(futsal.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(futsal: futsal),
                  ),
                );
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
