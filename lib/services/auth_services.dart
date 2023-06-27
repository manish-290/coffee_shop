import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //here we define all the methods required for the authentication
  //final means it not gonna change in future
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase User
  User_obj? _userFromFirebaseUser(User user){
    return user != null ? User_obj(uid: user.uid) : null;
  }

  //auth change user stream for signin and signout
  //user object for sign in and null for signout

  Stream<User_obj?> get user{

    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user!));
  }


  //sign in anonymously
//future is the class that computes or tells ide that there will be
//some delay for asynchronous operation
Future signInAnonym() async{
  try{
    //represents result of signing in  or creating user using firebase
    UserCredential result = await _auth.signInAnonymously();
    User? user = result.user;//provides user info,images
    return _userFromFirebaseUser(user!);
  }
  catch(e){
    print(e.toString());
    return null;
  }
}
  //sign in with email
Future signInWithEmailAndPassword(String email, String password) async{
  try{
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return _userFromFirebaseUser(user!);
  }
  catch(e){
    print(e.toString());
    return null;
  }
}

//register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      //we make a request to the firebase using _auth object
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create the new document for the user with uid
      await DatabaseService(uid:user!.uid).updateUserData('0', '${email}',100 );
      return _userFromFirebaseUser(user!);
    }
        catch(e){
        print(e.toString());
        return null;
        }
  }


  //sign out

Future signOut() async{
    try{
      return await _auth.signOut();
    }
        catch(e){
      print(e.toString());
      return null;
        }
}


}