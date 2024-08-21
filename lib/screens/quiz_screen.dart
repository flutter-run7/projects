import 'package:flutter/material.dart';
import 'package:biogenius4/data/module1_questions.dart';
import 'package:biogenius4/data/module2_questions.dart';
import 'package:biogenius4/data/module3_questions.dart';
import 'package:biogenius4/models/questions.dart';
import 'package:biogenius4/models/quiz_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:biogenius4/screens/ranking_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class QuizScreen extends StatefulWidget {
  final int moduleNumber;
  const QuizScreen({Key? key, required this.moduleNumber}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int moduleNumber;
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  bool isQuizCompleted = false;
  bool isAnswerLocked = false; // Variável para controlar se a resposta foi bloqueada

  String _getDisciplinaNome() {
    switch (widget.moduleNumber) {
      case 1:
        return 'Microbiologia';
      case 2:
        return 'Genética';
      case 3:return 'Patologia';
      default:
        return 'Desconhecido';
    }
  }

  @override
  void initState() {
    super.initState();
    moduleNumber = widget.moduleNumber;
    if (moduleNumber == 1) {
      questions = module1Questions;
    } else if (moduleNumber == 2) {
      questions = module2Questions;
    } else {
      questions = module3Questions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz de ${_getDisciplinaNome()}'), // Exibe o nome da disciplina
      ),
      body: Center(
        child: isQuizCompleted
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Parabéns, você concluiu o quiz do Módulo $moduleNumber!'),
            // Adicione outros widgets ou mensagens que desejar exibir aqui
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100], // Fundo azul claro
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  questions[currentQuestionIndex].text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < questions[currentQuestionIndex].options.length; i++)
              Container(
                width: double.infinity, // Largura máxima
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: isAnswerLocked
                      ? null
                      : () {
                    setState(() {
                      selectedAnswerIndex = i;
                      isAnswerLocked = true; // Bloqueia a resposta após a primeira seleção
                    });
                  },
                  child: Text(
                    questions[currentQuestionIndex].options[i],
                    style: TextStyle(fontSize: 16), // Aumenta o tamanho da fonte
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0), // Aumenta a altura do botão
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (selectedAnswerIndex != null)
              Text(
                selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex
                    ? 'Correto!'
                    : 'Incorreto!',
                style: TextStyle(
                  color: selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex) {
                    score++;
                  }
                  if (currentQuestionIndex < questions.length - 1) {
                    currentQuestionIndex++;
                    selectedAnswerIndex = null;
                    isAnswerLocked = false; // Desbloqueia a respostapara a próxima pergunta
                  } else {
                    // Finalizou o módulo atual
                    _mostrarDialogFinalizacaoModulo(context);
                  }
                });
              },
              child: Text(currentQuestionIndex < questions.length - 1 ? 'Próxima Pergunta' : 'Finalizar Módulo'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogFinalizacaoModulo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Parabéns!'),
          content: Text('Você concluiu o Módulo $moduleNumber!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _avancarParaProximoModuloOuRanking(context);
              },
              child: Text('Próximo Módulo'),
            ),
          ],
        );
      },
    );
  }

  void _avancarParaProximoModuloOuRanking(BuildContext context) {
    if (moduleNumber < 3) {
      // Substitua 3 pelo número total de módulos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(moduleNumber: moduleNumber + 1),
        ),
      );
    } else {
      // Navega para a tela de ranking após o último módulo
      Navigator.pushNamed(context, '/ranking');
    }
  }
}