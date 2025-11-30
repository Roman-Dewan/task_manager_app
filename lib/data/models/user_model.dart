class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobiile;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobiile,
  });

  // json to data
  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['_id'],
      email: jsonData['email'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      mobiile: jsonData['mobile'],
    );
  }

  // data to json
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobiile,
    };
  }
}
