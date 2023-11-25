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
