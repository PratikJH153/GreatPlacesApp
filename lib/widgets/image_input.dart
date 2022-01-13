import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile!.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final finalName = path.basename(imageFile!.path);

    final saveImage = await _storedImage!.copy("${appDir.path}/$finalName");
    widget.onSelectImage(saveImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No Image Taken!",
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            label: const Text("Take Picture"),
            icon: const Icon(Icons.camera),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
