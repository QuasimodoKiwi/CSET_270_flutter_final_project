import 'package:final_project/pages/make_projects.dart';
import 'package:final_project/pages/project_list.dart';
import 'package:final_project/pages/project_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: show_projects(),
  ));
}