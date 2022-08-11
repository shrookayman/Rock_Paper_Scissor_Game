import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rps_game/enums/result_enum.dart';
import '../components/my_text.dart';
import '../enums/game_enum.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codeplayon Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

var playerScore=0;
var cpuScore=0;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  GameEnum? userChoice;
  GameEnum? computerChoice;
  ResultEnum? finalResult;

  List cpuSelections = [
    GameEnum.rock,
    GameEnum.paper,
    GameEnum.scissor,
  ];
  late SharedPreferences logindata;
  late String username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1b2b4c),
        body: userChoice == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText('Rock'),
            MyText('Paper'),
            MyText('Scissors'),
            SizedBox(
              height: 15,
            ),
            Text(
              'Pick your weapon',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  userChoice = GameEnum.rock;
                });
                makeComputerSelect();
                calculations();
              },
              child: Image.asset(
                'assets/images/rock.png',
                height: 100,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  userChoice = GameEnum.paper;
                });
                makeComputerSelect();
                calculations();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/paper.png',
                  height: 100,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  userChoice = GameEnum.scissor;
                });
                makeComputerSelect();
                calculations();
              },
              child: Image.asset(
                'assets/images/scissor.png',
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '$username',
                        style: TextStyle(color: Colors.white),
                      ),
                      MyText('${playerScore}')
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'CPU',
                        style: TextStyle(color: Colors.white),
                      ),
                      MyText('${cpuScore}')
                    ],
                  )
                ],
              ),
            )
          ],
        )
            : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(finalResult!.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$username',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Image.asset(
                          'assets/images/${userChoice!.name}.png',
                          height: 100,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'CPU',
                          style: TextStyle(color: Colors.white),
                        ),
                        Image.asset(
                          'assets/images/${computerChoice!.name}.png',
                          height: 100,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 100,),

                Container(
                  width: 160,height: 50,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    child: Text( 'play again',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  width: 160,height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      reset();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    child: Text( 'reset score',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                  ),
                ),

                SizedBox(height: 50,),
                Container(
                  width: 160,height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      logindata.setBool('login', true);
                      reset();
                      Navigator.pushReplacement(context,
                          new MaterialPageRoute(builder: (context) => MyLoginPage()));
                    },
                    child: Text('Log out',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                  ),
                ),

              ],

            )));
  }


  void reset(){
    setState((){
      Navigator.pop(context);
      playerScore = 0;
      cpuScore=0;
    });

  }

  calculations() {
    // if user select rock
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpuScore++;
      });
      print(finalResult);
    }
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
    if (userChoice == GameEnum.rock && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.win;
        playerScore++;
      });
    }

    // if user select paper

    if (userChoice == GameEnum.paper && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
    if (userChoice == GameEnum.paper && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpuScore++;
      });
    }
    if (userChoice == GameEnum.paper && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.win;
        playerScore++;
      });
    }

    // if user select scissor
    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.paper) {
      setState(() {
        finalResult = ResultEnum.win;
        playerScore++;
      });
    }

    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.rock) {
      setState(() {
        finalResult = ResultEnum.lose;
        cpuScore++;
      });
    }

    if (userChoice == GameEnum.scissor && computerChoice == GameEnum.scissor) {
      setState(() {
        finalResult = ResultEnum.draw;
      });
    }
  }

  makeComputerSelect() {
    setState(() {
      Random random = Random();
      int selected = random.nextInt(3);
      computerChoice = cpuSelections[selected];
    });
  }
}


