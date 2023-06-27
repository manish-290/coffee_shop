import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/services/database.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
//for the use of the form
  final _formKey = GlobalKey<FormState>();
  //user selection of sugars amount
  final List<String> sugars = ['0','1','2','3','4'];

  late String _currentName;
  late String _currentSugars;
  late int _currentStrength;

  @override
  void initState(){
    super.initState();
    _currentStrength = 100;
    _currentSugars = '0';
    _currentName = 'Manish';
  }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User_obj?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your form',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'username'
                    ),
                    validator: (val) => val!.isEmpty
                        ? 'Please enter the name'
                        : null,
                    onChanged: (val) =>
                        setState(() {
                          _currentName = val;
                        }),
                  ),
                  SizedBox(height: 20.0,),

                  //dropdown
                  DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      decoration: textInputDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars')
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() {
                            _currentSugars = val!;
                          })
                  ),
                  SizedBox(height: 20.0,),

                  //slider for strength
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength.round() ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength.round() ??
                        userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                  ),
                  SizedBox(height: 20.0,),
                  //button
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.pink)
                      ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          await DatabaseService(uid:user.uid)
                          .updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength
                          );
                          Navigator.pop(context);
                        }


                        // print(_currentName);
                        // print(_currentSugars);
                        // print(_currentStrength);
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),

                  ),

                ],
              ),
            );
      }
          else {
              return Loading();
            }
      }
    );
  }
}
