import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/screens/authentication/authenticate.dart';
import 'package:coffee_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //accessing the user data from the provider
    final user = Provider.of<User_obj?>(context);

    //return either home or authenticate for logged in or not
    if(user == null){
      return Authenticate();
    } else {
      return Home();
    }
    }
  }

