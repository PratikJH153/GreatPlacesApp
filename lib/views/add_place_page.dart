import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greatplacesapp/providers/great_places.dart';
import 'package:greatplacesapp/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlacePage extends StatefulWidget {
  static const routeName = "/addPlace";
  const AddPlacePage({Key? key}) : super(key: key);

  @override
  _AddPlacePageState createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.trim().isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text.trim(), _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            label: const Text("Add Place"),
            icon: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
