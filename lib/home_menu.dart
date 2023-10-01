import 'package:flutter/material.dart';
import 'package:smart_parking/login.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Image.asset("assets/ic_menu_user.png"),
          title: const Text("My Profile",
              style: TextStyle(fontSize: 18, color: Color(0xff323643))),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_logout.png"),
          onTap: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogInPage()));
            });
          },
          title: const Text("Log Out",
              style: TextStyle(fontSize: 18, color: Color(0xff323643))),
        ),
      ],
    );
  }
}
