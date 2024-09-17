// ignore_for_file: prefer_final_fields

import 'package:kawaii_vision/project_screens/Quizzler/questions.dart';

class QuizBrain{

  // by adding _ the function is private
  // Therefore encapsulation is achieved
  int _questionNo = 0;


  List<Question> _questionBank = [
    Question('Let\'s start',false),
    Question('Color of sky is black',true),
    Question('The letter "J" is the only letter in the alphabet not included in the periodic table', true),
    Question('An astronaut has played golf on the moon.', true),
    Question('The Chinese New Year is celebrated on the same day every year.', false),
    Question('The New York Marathon is the largest in the world.', true),
    Question('World-renowned jeweler Tiffany & Co. is the maker of the Vince Lombardi trophy.', true),
    Question('The U.S. and Canada celebrate Thanksgiving on the same day.', false),
    Question('A potato was the first vegetable to be planted on the space shuttle.', true),
    Question('Toy Story was Pixar\'s first movie.', true),
    Question('The human eye can distinguish 10 million different colors.', true),
  ];

  void nextQuestion(){
    // after having _questionBank.length it goes up to 3(if satisfied) and ++ will make 4 which gives error
    // no 4th question therefore
    if(_questionNo < _questionBank.length-1){
      _questionNo++;
    }
  }

  bool checkLength(){
    if(_questionNo+1 == _questionBank.length){
      _questionNo = 0;
      return true;
    }
    return false;
  }

  String getQuestionText(){
    return _questionBank[_questionNo].questionText;
  }

  bool getQuestionAns(){
    return _questionBank[_questionNo].questionAns;
  }

}

