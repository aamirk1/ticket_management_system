import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management_system/auth/login.dart';
import 'package:ticket_management_system/splash_screen/splash_service.dart';

const white = Colors.white;
const black = Colors.black;
const purple = Colors.purple;
Future<void> signOut(context) async {
//  await FirebaseAuth.instance.signOut();
  await FirebaseAuth.instance.signOut().whenComplete(() {
    SplashService().removeLogin(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  });
}
