import 'package:flutter/material.dart';
import 'package:todo/ui/screens/auth/login/login_screen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, LoginScreen.routeName);
      },
      child: Text(
        "Sign out",
        style: TextStyle(fontSize: 18, color: Colors.black45),
      ),
    )
    ;
  }
}
