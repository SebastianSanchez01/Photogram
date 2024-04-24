import 'package:flutter/material.dart';
import 'package:photo_gram/screens/auth_service.dart';
import 'package:photo_gram/backend/firebase_options.dart';
import 'package:photo_gram/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:photo_gram/backend/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (_) => UserProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use Future.delayed to simulate a delay
    Future.delayed(Duration(seconds: 2), () {
      // After the delay, navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });

    return Scaffold(
      body: Center(
        child: Icon(Icons.camera),
      ),
    );
  }
}
