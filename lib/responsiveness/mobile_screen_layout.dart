import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/login_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("This is Mobile Screen", style: TextStyle(
              fontSize: 26
            ),),

            SizedBox(height: 10,),

            FilledButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
            }, child: Text("Log out", style: TextStyle(
              fontSize: 18
            ),))
          ],
        )
      ),
    ); 
  }
}