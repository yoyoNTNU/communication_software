import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAlbumAndroid extends StatefulWidget {
  @override
  PhotoAlbumAndroidState createState() => PhotoAlbumAndroidState();
}

class PhotoAlbumAndroidState extends State<PhotoAlbumAndroid> {
  List<Uint8List?> _images = []; // Use nullable Uint8List

  Future<void> importPhotos() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      for (final pickedImage in pickedImages) {
        final imageBytes = await pickedImage.readAsBytes();
        setState(() {
          _images.add(Uint8List.fromList(imageBytes));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Album'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust the number of columns as needed
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return _images[index] != null
              ? Image.memory(
                  _images[index]!,
                  fit: BoxFit.cover,
                )
              : Container(); // Placeholder for null images
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: importPhotos,
        tooltip: 'Import Photos',
        child: Icon(Icons.photo),
      ),
    );
  }
}
