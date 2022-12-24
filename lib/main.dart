import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'src/views/home_page/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAT75IYNRBYbuafPbSVmVdSQ-LM9HwrL-A",
            authDomain: "crud-temp.firebaseapp.com",
            projectId: "crud-temp",
            storageBucket: "crud-temp.appspot.com",
            messagingSenderId: "734302325780",
            appId: "1:734302325780:web:d67d0ba881ec0fa5586b01",
            measurementId: "G-6Z8CRHVQ28"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
