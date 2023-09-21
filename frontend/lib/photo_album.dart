import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'dart:io' as io;

class PhotoAlbum extends StatefulWidget {
  @override
  _PhotoAlbumState createState() => _PhotoAlbumState();
}

class _PhotoAlbumState extends State<PhotoAlbum> {
  List<Uint8List> _images = [];

  Future<void> _importPhotos() async {
    if (kIsWeb) {
      // Web-specific code for file selection
      final input = html.FileUploadInputElement()..accept = 'image/*';
      input.click(); // Trigger the file picker dialog

      input.onChange.listen((event) {
        final files = input.files;
        if (files != null) {
          for (final file in files) {
            final reader = html.FileReader();
            reader.onLoad.listen((e) {
              final result = reader.result as Uint8List;
              setState(() {
                _images.add(result);
              });
            });
            reader.readAsArrayBuffer(file);
          }
        }
      });
    } else {
      // Android-specific code using image_picker package
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
          return Image.memory(
            _images[index],
            fit: BoxFit.cover,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _importPhotos,
        tooltip: 'Import Photos',
        child: Icon(Icons.photo),
      ),
    );
  }
}
