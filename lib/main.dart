import 'package:flutter/material.dart';
import 'package:taxi_app/src/app.dart';
import 'package:taxi_app/src/blocs/auth_bloc.dart';
import 'package:taxi_app/src/resources/login_screen.dart';

void main() {
  runApp(BookingTaxi(
      new AuthBloc(),
      MaterialApp(
        home: LoginScreen(),
      )));
}
