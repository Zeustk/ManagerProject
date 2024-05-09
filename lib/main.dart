import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/ui/app.dart';
void main() async {
runApp(const MyApp());
await Firebase.initializeApp();
Get.put(AuthController());
} 

