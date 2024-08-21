import 'dart:async';
import 'package:flutter/material.dart';
import 'package:biogenius4/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () { // Defina o tempo de duração da splash screen (3 segundos no exemplo)
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthScreen(), // Navegue para a tela de login
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cor de fundo da splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.jpg'), // Imagem da logo
            SizedBox(height: 20),
            Text(
              'Seja Bem-Vindo(a)!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}