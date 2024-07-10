import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseRepositoryProvider = Provider(
  (ref) => FirebaseRepository(
    storage: FirebaseStorage.instance,
  ),
);

class FirebaseRepository {
  FirebaseRepository({
    required this.storage,
  });

  final FirebaseStorage storage;

  Future<String> storeFile(String ref, File file) async {
    UploadTask task = storage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await task;
    String url = await snap.ref.getDownloadURL();

    return url;
  }
}
