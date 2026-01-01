import 'package:flutter/material.dart';
import 'package:futsal_finder/models/futsal.dart';
import 'package:futsal_finder/screens/booking/booking_screen.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:provider/provider.dart';

class FutsalDetailScreen extends StatelessWidget {
  final Futsal futsal;

  const FutsalDetailScreen({super.key, required this.futsal});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(futsal.name),
              background: Hero(
                tag: futsal.id!,
                child: Image.network(
                  futsal.imageUrls.isNotEmpty ? futsal.imageUrls[0] : 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(futsal.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Text(futsal.location, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Text('\$${futsal.price}/hour', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16.0),
                  const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Text(futsal.description),
                  const SizedBox(height: 16.0),
                  const Text('Amenities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: futsal.amenities.map((amenity) => Chip(label: Text(amenity))).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Gallery', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: futsal.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.network(futsal.imageUrls[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (authService.user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(futsal: futsal),
                ),
              );
            } else {
              // Show a dialog or navigate to the login screen
            }
          },
          child: const Text('Book Now'),
        ),
      ),
    );
  }
}
