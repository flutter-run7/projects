import 'package:flutter/foundation.dart';
import 'package:biogenius4/data/module1_questions.dart';
import 'package:biogenius4/data/module2_questions.dart';
import 'package:biogenius4/data/module3_questions.dart';
import 'package:biogenius4/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biogenius4/screens/ranking_screen.dart';
import 'package:biogenius4/screens/quiz_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class QuizModel with ChangeNotifier {
  int currentModule = 1;
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswerLocked =false;
  bool showNextModuleButton = false;
  int? selectedAnswerIndex;

  void answerQuestion(int answerIndex, List<Question> questions) {
    selectedAnswerIndex = answerIndex;
    isAnswerLocked = true;
    if (answerIndex == questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }
    if (currentQuestionIndex == questions.length - 1) {
      showNextModuleButton = true;
    }
    notifyListeners();
  }

  void nextQuestion(List<Question> questions) {if (currentQuestionIndex < questions.length - 1) {
    currentQuestionIndex++;
    selectedAnswerIndex = null;
    isAnswerLocked = false;
    notifyListeners();
  }
  }

  void goToNextModule(BuildContext context, TextEditingController nomeController, Future<void> Function(int) updateRanking) {
    print('goToNextModule foi chamado!');

    // Salva a pontuação


    // Verifica se há mais módulos antes de avançar
    if (currentModule < 3) { // Substitua 3 pelo número total de módulos
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(moduleNumber: currentModule + 1),
        ),
      );
      currentModule++;
    } else {
      // Navega para a tela de ranking após o último módulo
      Navigator.pushNamed(context, '/ranking');
    }updateRanking(score);

    // Reseta o estado do quiz para o próximo módulo
    currentQuestionIndex = 0;
    score = 0;
    isAnswerLocked = false;
    showNextModuleButton = false;
    selectedAnswerIndex = null;

    notifyListeners();
  }

  // Função para obter uma informação concisa do status do ranking
  String getRankingStatus() {
    // Lógica para obter a posição do usuário no ranking
    int userPosition = getUserPosition(); // Substitua pela sua lógica

    if (userPosition == 1) {
      return "Você está em primeiro lugar no ranking!";
    } else if (userPosition <= 3) {
      return "Você está no top 3 do ranking!";
    } else if (userPosition <= 10) {
      return "Você está no top 10 do ranking!";
    } else {
      return "Sua posição no ranking é: $userPosition";
    }
  }

  // Função auxiliar para obter a posição do usuário no ranking (substitua pela sua lógica)
  int getUserPosition() {
    // ... Lógica para obter a posição do usuário no ranking ...
    return 1; // Exemplo: retorna a posição 1
  }
}




