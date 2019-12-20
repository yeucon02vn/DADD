import 'package:flutter/material.dart';
import 'package:taxi_app/src/blocs/auth_bloc.dart';
import 'package:taxi_app/src/resources/msg/ErrorMsg.dart';

import 'home_screen.dart';
import 'msg/delay_loading.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  
  @override
  void disponse() {
    authBloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB428),
        iconTheme: IconThemeData(color: Color(0xff3277D8)),
        elevation: 0 // đổ bóng = 0
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(), // max width + height
        color: Color(0xFFFFB428),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image.asset('ic_car_red.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text("Welcome to PKNL Taxi", style: TextStyle(fontSize: 22,color: Color(0xff333333)),
                ),
              ),
              Text("Signup with PKNL in simple steps",
              style: TextStyle(fontSize: 16,color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
                child:StreamBuilder(
                  stream: authBloc.nameStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _nameController,
                      style: TextStyle(fontSize: 18,color: Colors.black),
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: "Name",
                        prefixIcon: Container(width: 50, child: Image.asset("ic_user.png")),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffCED0D2),width: 1), borderRadius: BorderRadius.all(Radius.circular(6)))
                      )
                    );
                  }
                )  
              ),
              StreamBuilder(
                stream: authBloc.phoneStream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _phoneController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      labelText: "Phone Number",
                      prefixIcon: Container(width: 50, child: Image.asset("ic_phone.png")),
                      border:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xffCED0D2),width: 1), borderRadius: BorderRadius.all(Radius.circular(6)))
                    )
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child:StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 18,color: Colors.black),
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: "Email",
                        prefixIcon: Container(width: 50, child: Image.asset("ic_user.png")),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffCED0D2),width: 1), borderRadius: BorderRadius.all(Radius.circular(6)))
                      )
                    );
                  }
                )  
              ),
              StreamBuilder(
                stream: authBloc.passStream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _passController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                      errorText: snapshot.hasError ? snapshot.error : null,
                      labelText: "Password",
                      prefixIcon: Container(width: 50, child: Image.asset("ic_lock.png")),
                      border:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xffCED0D2),width: 1), borderRadius: BorderRadius.all(Radius.circular(6)))
                    )
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child:SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: _onClickSignUp,
                    child: Text("Signup", style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)))
                  )
                ), 
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account ", 
                    style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                  children: <TextSpan>[
                    TextSpan(
                      // recognizer: TapGestureRecognizer()
                      //         ..onTap = () {
                      //         },
                      text: "Login now",
                      style: TextStyle(fontSize: 18, color: Color(0xff3277D8))
                      )]
                  )
                )
              )
            ],
          ),
        ),),
    );
  }
  _onClickSignUp() {
    var isVaild = authBloc.isValid(_nameController.text, _emailController.text, _passController.text, _phoneController.text);
    if(isVaild) {
      // create user + loading 
      Loading.showLoading(context, 'Loading...');
      authBloc.signUp(_nameController.text, _emailController.text, _passController.text, _phoneController.text, () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }, (msg) {
        Loading.hideLoading(context);
        ErrorMsg.showErrorMsg(context, "Sign-In", msg);
      });
    }
  }
}