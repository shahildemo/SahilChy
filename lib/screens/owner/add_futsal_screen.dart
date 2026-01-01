
import 'package:flutter/material.dart';
import 'package:futsal_finder/models/futsal.dart';
import 'package:futsal_finder/services/auth_service.dart';
import 'package:futsal_finder/services/futsal_service.dart';
import 'package:provider/provider.dart';

class AddFutsalScreen extends StatefulWidget {
  const AddFutsalScreen({super.key});

  @override
  AddFutsalScreenState createState() => AddFutsalScreenState();
}

class AddFutsalScreenState extends State<AddFutsalScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  double _price = 0.0;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final futsalService = Provider.of<FutsalService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Futsal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
                onSaved: (value) => _location = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    futsalService.addFutsal(
                      Futsal(
                        name: _name,
                        location: _location,
                        price: _price,
                        description: _description,
                        ownerId: authService.user!.uid,
                        amenities: [],
                        imageUrls: [],
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Futsal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
