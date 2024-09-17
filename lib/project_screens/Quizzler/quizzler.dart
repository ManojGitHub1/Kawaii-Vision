// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// import 'question.dart'
import 'package:kawaii_vision/project_screens/Quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// This is called Modularization
QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  static const id = 'quizzler';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Center(
              child: Text(
                'QuizTime!',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            elevation: 10.0,
            shadowColor: Colors.grey,
            backgroundColor: Colors.black,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ));
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List<String> myString = ['a', 'b', 'c', 'd', 'e'];
  // void toPrint(){
  //   print(myString[3]),
  //   print(myString.indexof('a')),
  //   print(myString.add('f')),
  //   print(myString.insert(2, 'z')),
  // };

  // List<Widget>
  List<Icon> scoreKeeper = [
    // Empty list at beginning
    // Icon(
    //   Icons.check,
    //   color: Colors.green,
    // ),
    // Icon(
    //   Icons.close,
    //   color: Colors.red,
    // ),
  ];


  // _onAlertWithCustomImagePressed(context) {
  //   Alert(
  //     context: context,
  //     title: "Thank you!",
  //     desc: "I know my app is Awesome",
  //     image: Image.network(
  //       'https://images.unsplash.com/photo-1564485327155-805ebb10de8b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cXVpeiUyMG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
  //       height: 350,
  //     ),
  //     buttons: [
  //       DialogButton(
  //         onPressed: () {
  //           Navigator.of(context, rootNavigator: true).pop();
  //         },
  //         child: Text(
  //           "Cancel",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //       )
  //     ],
  //     style: AlertStyle(
  //       isCloseButton: false, // Disable default close button
  //       isOverlayTapDismiss: false, // Prevent closing by tapping outside
  //     ),
  //   ).show();
  // }




  _onAlertWithCustomImagePressed(BuildContext context) {
    Alert(
      context: context,
      style: AlertStyle(
        isCloseButton: true, // Optional close button
        isOverlayTapDismiss: false, // Prevent dismissal by tapping outside
        alertPadding: EdgeInsets.zero, // Remove padding to cover the entire popup
        backgroundColor: Colors.transparent, // Make background transparent
      ),
      content: Container(
        width: double.infinity,
        height: 400, // Adjust height according to your requirement
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image that covers the entire alert
            Image.network(
              'https://images.unsplash.com/photo-1564485327155-805ebb10de8b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cXVpeiUyMG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
              fit: BoxFit.cover, // Make the image cover the entire alert
            ),
            // Text and button on top of the image
            Positioned(
              top: 30,
              left: 20,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank you!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "I know my app is Awesome",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  DialogButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    color: Colors.transparent,
                    width: 120,
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      buttons: [], // No default buttons, as we're customizing with DialogButton in the content
    ).show();
  }






  void isFinished() {
    if (quizBrain.checkLength()) {
      _onAlertWithCustomImagePressed(context);
      // ElevatedButton(
      //   child: Text('Alert with Custom Image'),
      //   onPressed: () => _onAlertWithCustomImagePressed(context),
      // );
      scoreKeeper.clear();
    } else {
      quizBrain.nextQuestion();
    }
  }

  void checkAnswer(bool userPicked) {
    bool checkAnswer = quizBrain.getQuestionAns();
    setState(() {
      if (userPicked == checkAnswer) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        // print("user got wrong");
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      // to check end of question
      isFinished();
      // quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            // flex is giving this widget more space
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  // 'This is where the question text will go',
                  // questions.first,
                  // quizBrain.questionBank[questionNo].questionText,
                  quizBrain.getQuestionText(),
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    // backgroundColor: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(15),
          child: TextButton(
            onPressed: () {
              setState(() {
                // scoreKeeper.add will add the content at the end of the list
                // scoreKeeper.add(
                //   Icon(
                //     Icons.check,
                //     color: Colors.green,
                //   ),
                // );

                // below line of code can change the ans before it's checked
                // therefore Abstraction & Encapsulation is used
                // hence after making private its no longer can be changed in main
                // quizBrain.questionBank[questionNo].questionAns = true;
                // and also can't delete the question or answer
                // quizBrain.getQuestionText(questionNo) = null;

                // bool checkAnswer = quizBrain.questionBank[questionNo].questionAns;
                // moved to function
                // bool checkAnswer = quizBrain.getQuestionAns();
                // if(checkAnswer == true){
                //   print("true");
                // }
                // questionNo++;
                // quizBrain.nextQuestion();
                checkAnswer(true);
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text(
              'True',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(15),
          child: TextButton(
            onPressed: () {
              setState(() {
                checkAnswer(false);
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'False',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        )),
        Row(
          // As children takes widget
          children: scoreKeeper,
        )
      ],
    );
  }
}
