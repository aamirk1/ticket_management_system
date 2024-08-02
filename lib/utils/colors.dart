import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management_system/auth/login.dart';

const white = Colors.white;
const black = Colors.black;
const purple = Colors.purple;
Future<void> signOut(context) async {
  await FirebaseAuth.instance.signOut().whenComplete(() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  });
}
