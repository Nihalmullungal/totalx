import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:totalx/domain/modals/user_modal/user_modal.dart';
import 'package:totalx/presentation/common/firebase_constants.dart';

///////////////////// to upload image ////////////////////

Future<String> imageUpload(String image) async {
  try {
    String name = DateTime.now().toString();
    Reference reference =
        FirebaseStorage.instance.ref().child("user image/$name.jpg");
    TaskSnapshot upload = await reference.putFile(File(image));
    final String data = await upload.ref.getDownloadURL();
    return data;
  } catch (e) {
    log(e.toString());
    return e.toString();
  }
}

////////////////////// to add user //////////////////////

Future<void> addUser(UserModal val) async {
  try {
    await Future.delayed(const Duration(seconds: 3), () async {
      await FirebaseFirestore.instance.collection(FirebaseConstants.user).add({
        FirebaseConstants.name: val.name,
        FirebaseConstants.age: val.age,
        FirebaseConstants.image: val.image
      });
    });
  } catch (e) {
    log("error while adding user : ${e.toString()}");
  }
}
