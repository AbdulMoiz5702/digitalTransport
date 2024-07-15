import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalize_transport/Controller/Utils/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ownerData = FirebaseFirestore.instance.collection("ownerData");
  final driverData = FirebaseFirestore.instance.collection("driverData");
  final history = FirebaseFirestore.instance.collection("history");

  insertOwnerData(
      email, password, name, phone, cnic, token, url, context) async {
    try {
      var imageFile = await DatabaseService().uploadFile(url);

      await ownerData.doc(auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "cnic": cnic,
        "admin": true,
        "token": token,
        "url": imageFile
      });
      await auth.signOut();
      showSnackBar(context, "successfully signup");
      Navigator.pop(context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  insertDriverData(
      email, password, name, phone, cnic, token, url, context) async {
    try {
      var imageUrl = await uploadFile(url);
      await driverData.doc(auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "cnic": cnic,
        "admin": false,
        "token": token,
        'url': imageUrl
      });
      showSnackBar(context, "successfully signup");
      Navigator.pop(context);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  getUserInfo() async {
    var data = await driverData.doc(auth.currentUser!.uid).get();
    if (data.data() == null) {
      data = await ownerData.doc(auth.currentUser!.uid).get();
    }
    return data.data();
    // if (check == "owner") {
    //   var data = await ownerData.doc(auth.currentUser!.uid).get();
    //   return data.data()!['admin'];
    // } else {
    //   var data = await driverData.doc(auth.currentUser!.uid).get();
    //   return data.data()!['admin'];
    // }
  }

  getRegisteredDrivers() async {
    List<Map<String, dynamic>> driversList = [];
    await driverData.get().then((value) {
      var docs = value.docs;
      driversList = docs.map((doc) {
        return doc.data();
      }).toList();
    });

    return driversList;
  }

  storeRoute(
      {required vehicleId,
      required route,
      required driverName,
      required startTime,
      required endTime,
      required assigingDate,
      required reportingDate,
      required description}) async {
    await history.doc().set({
      "vehicle_id": vehicleId,
      "driver_name": driverName,
      "route": route,
      "start_time": startTime,
      "end_time": endTime,
      "assiging_date": assigingDate,
      "reporting_date": reportingDate,
      'description': description
    });
  }

  registerVehicle(id) async {
    await FirebaseFirestore.instance
        .collection('vehicles')
        .doc()
        .set({'vehicle_id': id.toString()});
  }

  getRegisteredVehicle() async {
    List<Map<String, dynamic>> vehicleList = [];
    await FirebaseFirestore.instance.collection('vehicles').get().then((value) {
      var docs = value.docs;
      vehicleList = docs.map((doc) {
        return doc.data();
      }).toList();
    });

    return vehicleList;
  }

  uploadFile(fileName) async {
    try {
      var ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child(FirebaseAuth.instance.currentUser!.uid);
      // var data = ref.child("$fileName.pdf");

      var uploadFile = await ref.putFile(File(fileName));
      var url = await uploadFile.ref.getDownloadURL();
      return url;
    } on FirebaseException {
      rethrow;
    }
  }

  saveNotification(title, body, time) async {
    await FirebaseFirestore.instance
        .collection('notification')
        .doc()
        .set({"title": title, "body": body, "time": time.toString()});
  }

   getDriverData(){
    return FirebaseFirestore.instance.collection("driverData").doc(auth.currentUser!.uid).snapshots();
  }

  getOwnerData(){
    return FirebaseFirestore.instance.collection("ownerData").doc(auth.currentUser!.uid).snapshots();
  }
}
