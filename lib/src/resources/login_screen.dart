import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:taxi_app/src/app.dart';
import 'package:taxi_app/src/resources/home_screen.dart';
import 'package:taxi_app/src/resources/msg/ErrorMsg.dart';
import 'package:taxi_app/src/resources/msg/delay_loading.dart';
import 'package:taxi_app/src/resources/register_screen.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Color(0xFFFFB428),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Image.asset('ic_car_green.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              Text(
                "Login to continue using PKNL App",
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email",
                    // filled: true,
                    // fillColor: Colors.blue,
                                
                    prefixIcon: Container(
                        width: 50, child: Image.asset("ic_mail.png")),
                     enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                     ),
                     border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))
                     ),
                      labelStyle: TextStyle(color: Colors.red)
                      ),
                    // border: OutlineInputBorder(
                    //     borderSide:
                    //         BorderSide(color: Color(0xffCED0D2), width: 1.0),
                    //     borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              TextField(
                controller: _passController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                   // filled: true,
                    // fillColor: Colors.blue,  
                    prefixIcon: Container(
                        width: 50, child: Image.asset("ic_phone.png")),
                     enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                     ),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(6))
                     ),
                      labelStyle: new TextStyle(color: Colors.red)
                      ),
              ),
              Container(
                constraints: BoxConstraints.loose(Size(double.infinity, 50)),
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _onClickLogin,
                    child: Text(
                      "Log In",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: RichText(
                  text: TextSpan(
                      text: "New user? ",
                      style: TextStyle(color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()));
                              },
                            text: "Sign up for a new account",
                            style: TextStyle(
                                color: Color(0xff3277D8), fontSize: 18))
                      ]),
                ),
              )
            ],
          ),
        ),
     ),
    );
  }
  void _onClickLogin() {
    String email = _emailController.text;
    String pass = _passController.text;
    var authBloc = BookingTaxi.of(context).authBloc;
    Loading.showLoading(context, "Loading...");
    authBloc.signIn(email, pass, () {
      Loading.hideLoading(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }, (msg) {
      Loading.hideLoading(context);
      ErrorMsg.showErrorMsg(context, "Sign-In", msg);
    });
  }
}