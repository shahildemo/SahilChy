import 'package:flutter/material.dart';
import 'package:futsal_finder/models/futsal.dart';
import 'package:futsal_finder/services/futsal_service.dart';
import 'package:futsal_finder/widgets/futsal_card.dart';
import 'package:provider/provider.dart';

class ManageFutsalsScreen extends StatelessWidget {
  const ManageFutsalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final futsalService = Provider.of<FutsalService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Futsal Fields'),
      ),
      body: StreamBuilder<List<Futsal>>(
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

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final futsal = snapshot.data![index];
              return FutsalCard(
                futsal: futsal,
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    futsalService.deleteFutsal(futsal.id!);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
