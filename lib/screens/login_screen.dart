import 'package:flutter/material.dart';
import 'package:rps_game/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyLoginPage> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
 // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child:
            Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage('assets/images/Wallpaper.jpg'),
                fit: BoxFit.cover,
              ),
            ),
              child: Column(
                children: [
                  SizedBox(height: 100,
                  ),
                  Text(
                      'Rock Paper Scissor',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff1b2b4c)),
                    ),
                  Image.asset('assets/images/rps.png',
                  width: 250,
                    height: 60,
                  ),

                  SizedBox(height: 70,),

                  Padding(
                    padding: const EdgeInsets.only(left: 40.0,right: 40),
                    child: TextFormField(
                      cursorColor: Color(0xff1b2b4c),
                      controller: username_controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff1b2b4c),
                            )
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'username',
                        labelStyle: TextStyle(
                          color: Color(0xff1b2b4c),
                        ),
                        filled: true,
                        fillColor: Colors.white,


                      ),
                    ),
                  ),
                  SizedBox(height: 33,),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0,right: 40),
                    child: TextField(
                      cursorColor: Color(0xff1b2b4c),
                      controller: password_controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1b2b4c),
                            )
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xff1b2b4c),
                        ),
                        filled: true,
                        fillColor: Colors.white,

                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: 170,height: 50,
                    decoration: BoxDecoration(
                      color:  Color(0xff1b2b4c),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        String username = username_controller.text;
                        String password = password_controller.text;
                        if (username != '' && password != '') {
                          print('Successfull');
                          logindata.setBool('login', false);
                          logindata.setString('username', username);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MySplash()));
                        }
                      },
                      child: Text("Log in",
                       style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),

                ],
              ),

        ),
      ),
    );
  }
}