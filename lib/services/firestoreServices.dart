import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirestoreService{
  final CollectionReference<Map<String, dynamic>> _collectionReference =
  FirebaseFirestore.instance.collection('projects');

  addDocument(Map<String, dynamic> data) async{
    await _collectionReference.add(data);
  }
}