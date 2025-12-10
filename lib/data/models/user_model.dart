class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobiile;
  final String photo;

  String get fullName{
    return "$firstName $lastName";
  }

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobiile,
    required this.photo
  });

  // json to data
  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['_id'],
      email: jsonData['email'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      mobiile: jsonData['mobile'],
      photo: jsonData['photo'] ?? ''
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
      "photo": photo
    };
  }
}
