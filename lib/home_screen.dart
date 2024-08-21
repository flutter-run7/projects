import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:biogenius4/profile_screen.dart';
import 'package:biogenius4/screens/quiz_screen.dart';
import 'package:biogenius4/screens/ranking_screen.dart';


void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biogenius App'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navegar para a tela de perfil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                );
              },
            ),
            ListTile(
              title: Text('Ranking'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RankingScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                await Future.delayed(Duration(seconds: 1));
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Olá! Tudo pronto para iniciar o seu quiz.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(moduleNumber: 1),
                    ),
                  );
                },
                child: Text('Iniciar Quiz'),
              ),
              SizedBox(height: 16),
              Text(
                'Módulos do Quiz',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              QuizModuleCard(
                title: 'Microbiologia',
                description: 'Conceitos sobre microorganismos',
                imagePath: 'assets/images/microbiologia.jpg', // Caminho da imagem
                moduleNumber: 1,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(moduleNumber: 1),
                    ),
                  );
                },
              ),
              QuizModuleCard(
                title: 'Genética',
                description: 'Conceitos sobre ciência da hereditariedade',
                imagePath: 'assets/images/genetica.jpg', // Caminho da imagem
                moduleNumber: 2,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(moduleNumber: 2),
                    ),
                  );
                },
              ),
              QuizModuleCard(
                title: 'Patologia',
                description: 'Quiz sobre diagnóstico das doenças',
                imagePath: 'assets/images/patologia.jpg', // Caminho da imagem
                moduleNumber: 3,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(moduleNumber: 3),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizModuleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final int moduleNumber;
  final VoidCallback onPressed;

  QuizModuleCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.moduleNumber,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: ListTile(
          leading: Image.asset(imagePath, width: 50, height: 50), // Exibe a imagem
          title: Text(title),
          subtitle: Text(description),
        ),
      ),
    );
  }
}


