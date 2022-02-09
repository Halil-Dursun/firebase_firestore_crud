
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../views/home_page_view.dart';

class FirebaseInitialize{
  final Future<FirebaseApp> _initialize = Firebase.initializeApp();

  Widget firebaseInitialize (){
    return FutureBuilder(
      future: _initialize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Beklenmeyen bir hata oluştu'),
          );
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}