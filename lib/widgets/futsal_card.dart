import 'package:flutter/material.dart';
import 'package:futsal_finder/models/futsal.dart';

class FutsalCard extends StatelessWidget {
  final Futsal futsal;
  final Widget? trailing;

  const FutsalCard({super.key, required this.futsal, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          futsal.imageUrls.isNotEmpty
              ? Image.network(
                  futsal.imageUrls[0],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/placeholder.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          ListTile(
            title: Text(futsal.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(futsal.location),
            trailing: trailing,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: \$${futsal.price}/hour'),
                const SizedBox(height: 8.0),
                Text(futsal.description),
                const SizedBox(height: 8.0),
                Text('Amenities: ${futsal.amenities.join(', ')}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
