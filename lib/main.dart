import 'package:coffee_app/screens/authentication/authenticate.dart';
import 'package:coffee_app/screens/authentication/signIn.dart';
import 'package:coffee_app/screens/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/services/auth_services.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: FirebaseOptions(
         apiKey: 'AIzaSyD3eWb_tVm70CsbRCrK0wOaXKxGtNK7yPA',
         appId: '1:388149088254:android:2cb74621bf38954a8abaaf',
         messagingSenderId: '388149088254',
         projectId: 'manish-coffee-shop')
   );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User_obj?>.value(
        // .map((user)=>user as User_obj)
      value:AuthService().user,
      initialData:  null,
      catchError: (context, error){
        print(error);
        return null;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Wrapper(),
      ),
    );
  }
}