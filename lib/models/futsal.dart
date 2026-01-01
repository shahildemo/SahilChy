import 'package:cloud_firestore/cloud_firestore.dart';

class Futsal {
  final String? id;
  final String name;
  final String location;
  final double price;
  final String description;
  final String ownerId;
  final List<String> amenities;
  final List<String> imageUrls;

  Futsal({
    this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.description,
    required this.ownerId,
    required this.amenities,
    required this.imageUrls,
  });

  factory Futsal.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Futsal(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      ownerId: data['ownerId'] ?? '',
      amenities: List<String>.from(data['amenities'] ?? []),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'location': location,
      'price': price,
      'description': description,
      'ownerId': ownerId,
      'amenities': amenities,
      'imageUrls': imageUrls,
    };
  }
}
