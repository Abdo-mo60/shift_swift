class UserInfoModel {
 // final String id;
  final String email;
  final String userName;
 final String firstName;
  final String lastName;

  final String phone;

  UserInfoModel({
  //  required this.id,
    required this.email,
    required this.userName,
   required this.firstName,
   required this.lastName,
    required this.phone,
  });
  factory UserInfoModel.fromJson(jsonData) {
    
    return UserInfoModel(
      email: jsonData['data']['email'],
      userName: jsonData['data']['userName'],
     firstName: (jsonData['data']['firstName']==null)?' ':jsonData['data']['firstName'],
     lastName:(jsonData['data']['lastName']==null)?' ':jsonData['data']['lastName'],
      phone: jsonData['data']['phoneNumber'],
    );
  }
}
