import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';
import 'main_screen.dart';

class UserState extends StatefulWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  _UserStateState createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot){
          if(userSnapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else if(userSnapshot.connectionState == ConnectionState.active){
            if(userSnapshot.hasData){
              return MainScreens();
            }else{
              return LandingPage();
            }
          }else if(userSnapshot.hasError){
            return Scaffold(
              body: Center(
                child: Text('Error Occurred'),
              ),
            );
          }else{
            return Scaffold(
              body: Center(
                child: Text('Error Occurred'),
              ),
            );
          }
        });
  }
}
