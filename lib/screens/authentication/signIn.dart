import 'package:coffee_app/services/auth_services.dart';
import 'package:coffee_app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/loading.dart';
import '../home/home.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
//instance of the class AuthService
  final  AuthService _auth = AuthService();
  //form global key for validation and identify our form
  final _formKey = GlobalKey <FormState>();

  bool loading =false;

  //textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        // leading: Image.asset('assets/'),
        title:Text("Login to Coffee Shop") ,
        centerTitle: true,
        backgroundColor: Colors.brown,
        elevation: 0,
        actions: [
          TextButton.icon(
              onPressed: () async{
                  widget.toggleView();
              },
              icon: Icon(Icons.person),
              label:Text('Register'))
        ],
      ),
      body: Container (
        padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText:'Email' ),
                validator: (val)=> val!.isEmpty? 'Enter the email address': null,
                onChanged: (val){
                    setState(() {
                      email =val ;
                    });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText:'Password' ),
              validator: (val)=> val!.length <6 ? 'Enter the password at least 6 chars':null,
                onChanged: (val){
                  setState(() {
                    password =val ;
                  });
                },
                obscureText: true,
              ),
              SizedBox(height: 20.0,),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                  onPressed: () async{

                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Failed to sign in!';
                          loading = false;
                        });

                      }
                    }
                  },
                  child: Text(
                      'Login',
                  style:TextStyle(color: Colors.white)),
                  ),

              SizedBox(height: 20.0,),

              Text(
                error,
                style: TextStyle(color: Colors.redAccent),
              ),

              SizedBox(height: 20.0,),
              // TextButton(
              //     onPressed: (){
              //       onTap:Navigator.pushNamed(context, '/register.dart');
              //     },
              //     child: Text(
              //       'New here? Register as a user.',
              //       style: TextStyle(color: Colors.blue),
              //     ))
            ],
          ),
        ),


                  // ElevatedButton(
                  //     onPressed: () async{
                  //       dynamic result = await _auth.signInAnonym();
                  //       if(result == null){
                  //         print('error signing in');
                  //       }
                  //       else{
                  //         print('Signed in!');
                  //         print(result.uid);
                  //       }
                  //
                  //     },
                  //     child: Text('Login'),
                  //     color: Colors.lightBlue),


            ),

      // Container(
      //   padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0),
      //   child: ElevatedButton(
      //     onPressed: () {

      //     },
      //     color: Colors.red,
      //     child: Text('Sigin Anon'),
      //   ),
      // )
    );
  }

  }

