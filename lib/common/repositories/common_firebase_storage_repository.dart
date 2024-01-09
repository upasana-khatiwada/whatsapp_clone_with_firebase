import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

//this class is used for storing file in firebase like image vedio audio etc
class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({required this.firebaseStorage});
  Future<String> storeFileToFirebase(String ref, File file) async {
    //upload task is A class which indicates an on-going upload task
    //they are communicating with firebase console and child contains a path where data is gonna store
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);

    TaskSnapshot snap = await uploadTask;

    //since it was upload to firebase storage and now we need in firestore we need download url
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
