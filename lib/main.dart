import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_islemleri2_crud/data/firebase_initialize.dart';
import 'package:flutter/material.dart';

import 'views/home_page_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final FirebaseInitialize _firebaseInitialize = FirebaseInitialize();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:_firebaseInitialize.firebaseInitialize(),
    );
  }
}

