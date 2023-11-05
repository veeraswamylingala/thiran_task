import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_thiran/Views/widget_helper.dart';

class FirebaseHelper {
  final FirebaseStorage _storage = FirebaseStorage.instance;

//Upload apiHelper to Firebase Cloud_Storage
  Future<bool> uploadStickerPack(Map stickerPack, String docName) async {
    bool res = false;
    CollectionReference colRef =
        FirebaseFirestore.instance.collection("Tickets");

    await colRef
        .doc(docName)
        .set(stickerPack)
        .then((value) => {res = true})
        .catchError((e) {
      print("--------------");
      print(e);
      res = false;
    });

    print("Uploaded $res");
    return res;
  }

  Future<String?> uploadPic({required BuildContext context}) async {
    try {
      //Get the file from the image picker and store it
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        print(image.path);
        Reference reference = _storage.ref().child("Attachments/");
        UploadTask uploadTask = reference.putFile(File(image.path));

        // Waits till the file is uploaded then stores the download url
        String location = await uploadTask.snapshot.ref.getDownloadURL();
        return location;
      } else {
        return null;
      }
    } catch (e) {
      showToast(message: "Something went wrong ry again $e", context: context);
    }
    return null;
  }
}
