import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


QuizBrain quizBrain=QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper= [];
  // List<String> questions=[
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];

  //   List<bool> answers=[false,true,true];
  //
  // Questions q1=Questions(q: 'You can lead a cow down stairs but not up stairs.', a: false);
  // Questions q2=Questions(q: 'Approximately one quarter of human bones are in the feet.', a: true);
  // Questions q3=Questions(q: 'A slug\'s blood is green.', a: true);
    void modal(){
      Alert(
        context: context,
        type: AlertType.info,
        title: "Finished",
        desc: "You\'hv finished here.",
        buttons: [
          DialogButton(
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () =>
            {
              Navigator.pop(context),
              quizBrain.isFinished(),
              setState(() {
                scoreKeeper=[];
              }),
            },
          ),
        ],
      ).show();
    }
    void checkAnswer(bool corrAns){
      if(quizBrain.isEndReached){
        modal();
      }
      else
    setState(() {
    scoreKeeper.add(
     Icon(
      corrAns ? Icons.check : Icons.close,
     color:corrAns ? Colors.green : Colors.red,
    ),);
    });
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
         Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                color: Colors.green,
                child: Material(
                    color: Colors.transparent,
           child:InkWell(
             // textColor: Colors.white,
              child: const Center(
                child:  Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              onTap: () {
              bool corrAnswer=  quizBrain.getQuestionAnswer();
              checkAnswer(corrAnswer==true);
              setState(() {
               quizBrain.nextQuestion();
              });
              },
            )
                )
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                color: Colors.red,
           child: Material(
               color: Colors.transparent,
               child:InkWell(
                 child:const  Center(
                   child: Text(
                     'False',
                     style: TextStyle(
                       fontSize: 20.0,
                       color: Colors.white,
                     ),
                   ),
                 ),
                 onTap: () {
                   bool corrAnswer=quizBrain.getQuestionAnswer();
                   checkAnswer(corrAnswer==false);
                   setState(() {
                     quizBrain.nextQuestion();
                  });
                 },),
           ),
            ),
          ),
        ),
         Row(
           children:scoreKeeper,
         )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

// setState(() {
// scoreKeeper.add( const Icon(
// Icons.check,
// color: Colors.green,
// ),);
// });