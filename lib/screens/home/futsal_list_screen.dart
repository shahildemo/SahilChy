
import 'package:flutter/material.dart';
import 'package:futsal_finder/models/futsal.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:futsal_finder/services/futsal_service.dart';
import 'package:futsal_finder/widgets/futsal_card.dart';
import 'package:provider/provider.dart';

class FutsalListScreen extends StatefulWidget {
  const FutsalListScreen({super.key});

  @override
  State<FutsalListScreen> createState() => _FutsalListScreenState();
}

class _FutsalListScreenState extends State<FutsalListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final futsalService = Provider.of<FutsalService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Futsal Finder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Futsal>>(
              stream: futsalService.getFutsals(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No futsal fields found.'));
                }

                final futsals = snapshot.data!.where((futsal) {
                  return futsal.name.toLowerCase().contains(_searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  itemCount: futsals.length,
                  itemBuilder: (context, index) {
                    final futsal = futsals[index];
                    return FutsalCard(
                      futsal: futsal,
                      trailing: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Book ${futsal.name}'),
                              content: const Text('This feature is coming soon!'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Book Now'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
