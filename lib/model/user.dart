class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;

  User({required this.firstName, required this.lastName, required this.email, required this.phoneNumber, required this.password,});

  // now create converter

  factory User.fromJson(Map<String,dynamic> responseData){
    return User(
      firstName: responseData['firstName'],
      lastName: responseData['lastName'],
      email : responseData['email'],
      phoneNumber: responseData['phoneNumber'],
      password: responseData['password'],
    );
  }
}