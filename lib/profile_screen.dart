import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:biogenius4/screens/ranking_screen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userEmail;
  int? userRanking;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    setState(() {
      userEmail = user.email;
    });

    // Move a busca dos dados para dentro do if (user != null)
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (userData.exists) {
      setState(() {
        userRanking = userData.get('ranking') as int?;
      });
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userEmail != null) Text('Email: $userEmail'),
            if (userRanking != null) Text('Ranking: $userRanking'),
          ],
        ),
      ),
    );
  }
}