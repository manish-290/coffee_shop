import 'package:coffee_app/services/auth_services.dart';
import 'package:coffee_app/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //instance of the class AuthService
  final  AuthService _auth = AuthService();
  //form global key for validation and identify our form
  final _formKey = GlobalKey <FormState>();

  bool loading = false;

//textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        // leading: Icon(Icons.login),
        title:Text("Register to Coffee Shop") ,
        centerTitle: true,
        backgroundColor: Colors.brown,
        elevation: 0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async{
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label:Text('Login'))
        ],
      ),
      body: Container (
        padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0),
        child: Form(
          //keep the track and state of our form whats happening
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText:'Email' ),

                validator: (val)=> val!.isEmpty ? 'Enter an email': null,
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
                validator: (val)=> val!.length <6 ? 'Enter the password at least 6 chars': null,
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
                    // dynamic result = await _auth.signInWithEmail();
                   //is our form valid?
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if(result == null){
                    setState(() {
                      error = 'Please enter the valid email or password';
                      loading = false;
                    });
                  }
                    }
                  },
                  child: Text(
                      'Register',
                      style:TextStyle(color: Colors.white)),
                  ),

              SizedBox(height: 20.0,),
              //error message
              Text(
                error,
                style: TextStyle(color: Colors.redAccent),
              ),
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
