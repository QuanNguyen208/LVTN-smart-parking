import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking/firebase/auth_bloc.dart';
import 'package:smart_parking/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
        AuthBloc(),
       const MaterialApp(
        home: LogInPage(),
      )));
}

class MyApp extends InheritedWidget {
  final AuthBloc authBloc;
  final Widget child;
  const MyApp(this.authBloc, this.child, {super.key}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static MyApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyApp>();
  }
}

