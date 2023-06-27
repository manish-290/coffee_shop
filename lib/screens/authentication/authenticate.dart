import 'package:coffee_app/screens/authentication/register.dart';
import 'package:coffee_app/screens/authentication/signIn.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void  toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView:toggleView);
    }
    // return Container(
    //   child:Register()
    // );
  }
}
