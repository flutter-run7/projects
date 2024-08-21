import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'package:biogenius4/firebase_options.dart';
import 'package:biogenius4/models/quiz_model.dart';
import 'package:provider/provider.dart';
import 'package:biogenius4/screens/quiz_screen.dart';
import 'package:biogenius4/screens/ranking_screen.dart';
import 'package:biogenius4/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login and Signup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Mantém a tela de login como tela inicial
      routes: {
        '/registro': (ctx) => RegisterScreen(),
        '/home': (ctx) => HomeScreen(),
        '/quiz': (ctx) => QuizScreen(moduleNumber: 1), // Rota para QuizScreen
        '/ranking': (ctx) => RankingScreen(), // Rota para RankingScreen (opcional)
      },
    );
  }
}

