import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/v1.dart';
import 'package:uuid/v5.dart';

class StorageMethods {
  Future<String> uploadImage(
      {required String childName,
      required bool isPost,
      required Uint8List imageData}) async {
    final storageInstance = FirebaseStorage.instance;
    final auth = FirebaseAuth.instance;

    Reference ref =
        storageInstance.ref().child(childName).child(auth.currentUser!.uid);

    if (isPost) {
      final String uuid = const UuidV1().generate();
      ref = ref.child(uuid);
    }
    final UploadTask uploadTask = ref.putData(imageData);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
