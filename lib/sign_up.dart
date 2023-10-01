import 'package:flutter/material.dart';
import 'package:smart_parking/home.dart';
import 'package:smart_parking/login.dart';
import 'package:smart_parking/firebase/auth_bloc.dart';
import 'package:smart_parking/msg_dialog.dart';
import 'package:smart_parking/dialog_loading.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthBloc authBloc = AuthBloc();
  bool _showPw = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 80),
          constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Text(
                      "Create a new account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff323643),
                          fontSize: 25),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: StreamBuilder(
                      stream: authBloc.nameStream,
                      builder: (context, snapshot) => TextField(
                          controller: _usernameController,
                          style: const TextStyle(
                              fontSize: 15, color: Color(0xff323643)),
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? '${snapshot.error}'
                                  : null,
                              labelText: "Username",
                              prefixIcon: SizedBox(
                                width: 50,
                                child: Image.asset("assets/ic_user.png"),
                              ),
                              labelStyle: const TextStyle(
                                  color: Color(0xff323643), fontSize: 20),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff323643), width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))))),
                ),
                StreamBuilder(
                    stream: authBloc.emailStream,
                    builder: (context, snapshot) => TextField(
                        controller: _emailController,
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xff323643)),
                        decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? '${snapshot.error}' : null,
                            labelText: "Email",
                            prefixIcon: SizedBox(
                              width: 50,
                              child: Image.asset("assets/ic_mail.png"),
                            ),
                            labelStyle: const TextStyle(
                                color: Color(0xff323643), fontSize: 20),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff323643), width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)))
                        ))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: StreamBuilder(
                      stream: authBloc.phoneStream,
                      builder: (context, snapshot) => TextField(
                          controller: _phoneController,
                          style: const TextStyle(
                              fontSize: 15, color: Color(0xff323643)),
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? '${snapshot.error}'
                                  : null,
                              labelText: "Phone",
                              prefixIcon: SizedBox(
                                width: 50,
                                child: Image.asset("assets/ic_phone.png"),
                              ),
                              labelStyle: const TextStyle(
                                  color: Color(0xff323643), fontSize: 20),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff323643), width: 2),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6)))))),
                ),
                StreamBuilder(
                    stream: authBloc.passStream,
                    builder: (context, snapshot) => TextField(
                        controller: _passController,
                        obscureText: !_showPw,
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xff323643)),
                        decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? '${snapshot.error}' : null,
                            labelText: "Password",
                            prefixIcon: SizedBox(
                              width: 50,
                              child: Image.asset("assets/ic_lock.png"),
                            ),
                            suffixIcon: SizedBox(
                              width: 50,
                              child: GestureDetector(
                                onTap: showPassword,
                                child: Image.asset("assets/eye.png"),
                              ),
                            ),
                            labelStyle: const TextStyle(
                                color: Color(0xff323643), fontSize: 20),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff323643), width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)))))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            onPressed: signUpClicked,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff323643),
                                foregroundColor: Colors.white),
                            child: const Text("SIGN UP")))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            onPressed: userClicked,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff323643),
                                foregroundColor: Colors.white),
                            child: const Text("BACK")))),
              ]),
        )));
  }

  void showPassword() {
    setState(() {
      _showPw = !_showPw;
    });
  }

  signUpClicked() {
    var isValid = authBloc.isValid(_usernameController.text,
        _emailController.text, _phoneController.text, _passController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(_usernameController.text, _emailController.text,
          _phoneController.text, _passController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign Up", msg);
      });
    }
  }

  void userClicked() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LogInPage()));
    });
  }
}
