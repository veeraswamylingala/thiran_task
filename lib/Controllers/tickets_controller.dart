import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_thiran/Services/firebase_helper.dart';

class TicketController extends GetxController {
  FirebaseHelper apiHelper = FirebaseHelper();

  //Tickets Getter
  Stream<QuerySnapshot> get fetchTicketsStream => _ticketsStream;

//Fetch Tickets rom Firebase Cloud_Stoatge
  final Stream<QuerySnapshot> _ticketsStream =
      FirebaseFirestore.instance.collection('Tickets').snapshots();

//Upload Tickets to Firebase Cloud_Storage
  Future<bool> uploadStickerPack(Map stickerPack, String docName) {
    return apiHelper.uploadStickerPack(stickerPack, docName);
  }

//Upload Attachemnet to Firebase Cloud_Storage
  Future<String?> uploadAttachment({required BuildContext context}) {
    return apiHelper.uploadPic(context: context);
  }
}
