import 'package:smart_parking/sign_up.dart';
import 'package:smart_parking/dialog_loading.dart';
import 'package:smart_parking/msg_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking/home.dart';
import 'package:smart_parking/main.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool _showPw = false;
  final TextEditingController _controlEmail = TextEditingController();
  final TextEditingController _controlPassword = TextEditingController();
  final _emailError = "INVALID EMAIL ADDRESS!";
  final _passwordError = "PASSWORD MUST HAVE AT LEAST 6 CHARACTERS!";
  final _emailInvalid = false;
  final _passwordInvalid = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
            home: Scaffold(
                resizeToAvoidBottomInset: false, // fix bottom overloaded by pixels
                body: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
          constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                        child: const FlutterLogo())),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
                    child: Text(
                      "WELCOME TO K19!\nA SMART PARKING APP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff323643),
                          fontSize: 30),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      style: const TextStyle(
                          fontSize: 15, color: Color(0xff323643)),
                      controller: _controlEmail,
                      decoration: InputDecoration(
                          prefixIcon: SizedBox(
                            width: 50,
                            child: Image.asset("assets/ic_mail.png"),
                          ),
                          labelText: "Email",
                          border: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff323643), width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          errorText: _emailInvalid ? _emailError : null,
                          labelStyle: const TextStyle(
                              color: Color(0xff323643), fontSize: 20)),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: <Widget>[
                          TextField(
                              style: const TextStyle(
                                  fontSize: 15, color: Color(0xff323643)),
                              controller: _controlPassword,
                              obscureText: !_showPw,
                              decoration: InputDecoration(
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
                                labelText: "Password",
                                border: const OutlineInputBorder(),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff323643), width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                errorText:
                                    _passwordInvalid ? _passwordError : null,
                                labelStyle: const TextStyle(
                                    color: Color(0xff323643), fontSize: 20),
                              )),
                        ])),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            onPressed: userClicked,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff323643),
                                foregroundColor: Colors.white),
                            child: const Text("SIGN IN")))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: RichText(
                      text: TextSpan(
                          text: "New user ? ",
                          style: const TextStyle(
                              color: Color(0xff323643), fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Register()));
                                  },
                                text: "SIGN UP!",
                                style: const TextStyle(
                                    color: Colors.lightBlue, fontSize: 16))
                          ]),
                    )),
              ]),
        ))));
  }

  void showPassword() {
    setState(() {
      _showPw = !_showPw;
    });
  }

  void userClicked() {
    String email = _controlEmail.text;
    String pass = _controlPassword.text;
    var authBloc = MyApp.of(context)?.authBloc;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc?.signIn(email, pass, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", msg);
    });
  }
}
