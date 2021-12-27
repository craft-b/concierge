import 'package:concierge/screens/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMaganger {
  static FirebaseFirestore? _instance;
  static const DATABASE_NAME = 'trips';

  static Future initalize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _instance = FirebaseFirestore.instance;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots() {
    return FirebaseFirestore.instance.collection('trips').snapshots();
  }

  static void addTrip(Trip entry) async {
    await FirebaseFirestore.instance.collection(DATABASE_NAME).add({
      'title': entry.title,
      // 'documentID': entry.documentID,
      'endDate': entry.endDate,
      'itenerary': entry.itenerary,
      // 'notes': entry.notes,
      // 'photoReference': entry.photoReference,
      'startDate': entry.startDate,
      // 'travelType': entry.travelType,
    });
  }
}
