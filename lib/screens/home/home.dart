
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/screens/authentication/authenticate.dart';
import 'package:coffee_app/screens/home/brew_list.dart';
import 'package:coffee_app/screens/home/settings_form.dart';
import 'package:coffee_app/services/auth_services.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/services/database.dart';
import 'package:provider/provider.dart';
import '../../models/brew.dart';
import '../../services/auth_services.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void  _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding:  EdgeInsets.symmetric(vertical:20.0,horizontal:60.0),
              child:  SettingsForm()
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value:DatabaseService(uid: 'uid').brews ,
      initialData: null,

      child: Scaffold(
        backgroundColor: Colors.brown[100],


        appBar: AppBar(

          title:  Text('Welcome to Manish Coffee Stall!'),
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
          //action expects the button inside appbar
          actions:<Widget> [
            TextButton.icon(
                onPressed: () async{
                  await _auth.signOut();
                },
                icon:  Icon(Icons.person),
                label: Text('logout')),

            TextButton.icon(
                onPressed: () {
                  _showSettingsPanel();
                },
                icon:  Icon(Icons.settings),
                label: Text('Settings')),

          ],
        ),
        body: Container(
          decoration:  BoxDecoration(
            image:DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover
            )
          ),
            child: BrewList()),
      ),
    );
  }
}
