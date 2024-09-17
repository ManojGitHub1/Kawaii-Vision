class Question {
  // Use the late keyword to initialize a variable when it is first read, rather than when it's created.
  late String questionText;
  late bool questionAns;

  // {} is used for labeling
  // Question({required String q,required bool a})
  // Question(String q,bool a){
  //   questionText = q;
  //   questionAns = a;
  // }
  Question(this.questionText, this.questionAns);
}