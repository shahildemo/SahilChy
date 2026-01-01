import 'package:flutter/material.dart';
import 'package:futsal_finder/models/futsal_field.dart';
import 'package:futsal_finder/screens/home/futsal_field_detail_screen.dart';

class FutsalFieldList extends StatelessWidget {
  final String searchQuery;

  const FutsalFieldList({super.key, required this.searchQuery});

  final List<FutsalField> futsalFields = const [
    FutsalField(
      id: '1',
      name: 'Futsal Court A',
      address: '123 Main St',
      imageUrl: 'https://picsum.photos/200/300',
      pricePerHour: 25.0,
    ),
    FutsalField(
      id: '2',
      name: 'Futsal Court B',
      address: '456 Oak Ave',
      imageUrl: 'https://picsum.photos/200/300',
      pricePerHour: 30.0,
    ),
    FutsalField(
      id: '3',
      name: 'Futsal Court C',
      address: '789 Pine Ln',
      imageUrl: 'https://picsum.photos/200/300',
      pricePerHour: 28.0,
    ),
    FutsalField(
      id: '4',
      name: 'Futsal Court D',
      address: '101 Maple St',
      imageUrl: 'https://picsum.photos/200/300',
      pricePerHour: 35.0,
    ),
    FutsalField(
      id: '5',
      name: 'Futsal Court E',
      address: '212 Birch Rd',
      imageUrl: 'https://picsum.photos/200/300',
      pricePerHour: 22.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFields = futsalFields.where((field) {
      return field.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredFields.length,
      itemBuilder: (context, index) {
        final field = filteredFields[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FutsalFieldDetailScreen(field: field),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(field.imageUrl),
              title: Text(field.name),
              subtitle: Text(field.address),
              trailing: Text('\$${field.pricePerHour}/hr'),
            ),
          ),
        );
      },
    );
  }
}
