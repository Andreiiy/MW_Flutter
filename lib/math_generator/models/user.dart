


class User{
  int id;
  String? idOneSignal;
  String firstName;
  String lastName;
  String? email;
  String password;
  String country;





  Map<String, dynamic> toJson() => {
    'id': id,
    'id_one_signal': idOneSignal,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'password': password,
    'country': country
  };

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,
        password = json['password'] as String,
        country = json['country'] as String;

}
