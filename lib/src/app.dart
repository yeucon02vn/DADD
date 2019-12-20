import 'package:flutter/material.dart';
import 'package:taxi_app/src/blocs/auth_bloc.dart';

class BookingTaxi extends InheritedWidget {
  final AuthBloc authBloc;
  final Widget child;
  BookingTaxi(this.authBloc, this.child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static BookingTaxi of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(BookingTaxi);
  }
}
