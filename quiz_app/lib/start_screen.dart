import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

// Funzione passata dal genitore per iniziare il quiz
  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo dell'app quiz
          Image.asset(
            'assets/img/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(height: 80),
                   // Titolo del quiz
          const Text(
            'La mia prima quiz app',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
           // Bottone per iniziare il quiz
          OutlinedButton.icon(
            // Chiama la funzione per cambiare schermata
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Inizia il quiz'),
          ),
        ],
      ),
    );
  }
}
