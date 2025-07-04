import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/login_screen.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("This is Web Screen", style: TextStyle(
              fontSize: 36
            ),),

            SizedBox(height: 10,),

            FilledButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
            }, child: Text("Log out", style: TextStyle(
              fontSize: 20
            ),))
          ],
        )
      ),
    ); 
  }
}