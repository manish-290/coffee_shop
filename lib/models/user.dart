class User_obj{
  final String uid;

  User_obj({required this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({required this.uid, required this.name,
            required this.sugars, required this.strength
  });
}