import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

// Risposte date dall'utente
  final List<String> chosenAnswers;
  // tutti i valori in DART sono oggetti, alla fine si tratta di un tipo abbastanza flessibile 
  // che consente tutti i tipi di valori e che mi permette di memorizzare diversi tipi di valori in questa mappa
  List<Map<String, Object>> getSummaryData() {
    final  List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++){
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
        },
      );
    }
    return summary;
  }
  // Callback per ricominciare
  final void Function() onRestart;

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
     final numTotalQuestions = questions.length;
     final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
     }).length;
    return 
      SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            'Ha risposto correttamente a $numCorrectQuestions su $numTotalQuestions domande',
            style: TextStyle(color: Colors.deepPurple, fontSize: 24),
          ),
          const SizedBox(height: 20,),
          QuestionsSummary(summaryData),
          const SizedBox(height: 20,), 
          ElevatedButton(
            onPressed: onRestart,
            child: const Text('Ricomincia'),
          )
        ],
      ),
      ),
      );
  }
}
