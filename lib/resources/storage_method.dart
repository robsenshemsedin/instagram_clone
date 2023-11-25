import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future<String> uploadImage(
      {required String childName,
      required bool isPost,
      required Uint8List imageData}) async {
    final storageInstance = FirebaseStorage.instance;
    final auth = FirebaseAuth.instance;

    final ref =
        storageInstance.ref().child(childName).child(auth.currentUser!.uid);

    final UploadTask uploadTask = ref.putData(imageData);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
