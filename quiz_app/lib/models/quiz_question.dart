class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

 // Restituisce le risposte in ordine casuale
  List<String> getShuffledAnswers() {
    final List<String> shuffledList = List.of(answers); 
    shuffledList.shuffle();
    return shuffledList;
  }
}
