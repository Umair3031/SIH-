import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bliss/main.dart';
import 'package:flutter/material.dart';
import 'package:bliss/screens/homepage.dart';

Future<void> userSetup(String firstname, String lastname, String email, String password) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();
  users.add({
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'password': password
  });
  return;
}