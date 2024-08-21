import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import'package:biogenius4/models/quiz_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RankingScreen extends StatelessWidget {
  // Lista de exemplo para o ranking
  final List<Map<String, dynamic>> rankingData = [
    {"name": "Usuário 1", "points": 1500, "position": 1},
    {"name": "Usuário 2", "points": 1200, "position": 2},
    {"name": "Usuário 3", "points": 1100, "position": 3},
    {"name": "Usuário 4", "points": 950, "position": 4},
    {"name": "Usuário 5", "points": 850, "position": 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Sua Posição: 2',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rankingData.length,
              itemBuilder: (context, index) {
                final item = rankingData[index];
                return ListTile(
                  leading: Text(
                    item["position"].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  title: Text(
                    item["name"],
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Text(
                    item["points"].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




void main() {
  runApp(MaterialApp(
    home: RankingScreen(),
  ));
}
