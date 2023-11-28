import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  XFile? file = await ImagePicker().pickImage(source: source);
  if (file != null) {
    return file.readAsBytes();
  }
  debugPrint('User did not picked any Image.');
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<Uint8List?> pickProfileImage(BuildContext parentContext) async {
  const padding = EdgeInsets.all(20);
  Uint8List? inerFile;
  await showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
            title: const Text('Create a Post'),
            children: <Widget>[
              SimpleDialogOption(
                  padding: padding,
                  child: const Text('Take a photo'),
                  onPressed: () async {
                    Uint8List file = await pickImage(ImageSource.camera);
                    inerFile = file;
                    if (!context.mounted) return;

                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  padding: padding,
                  child: const Text('Choose from Gallery'),
                  onPressed: () async {
                    Uint8List file = await pickImage(ImageSource.gallery);
                    inerFile = file;
                    if (!context.mounted) return;

                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                padding: padding,
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]);
      });
  return inerFile;
}
