class UserInfoModel {
 // final String id;
  final String email;
  final String userName;
 // final String fullName;
  final String phone;

  UserInfoModel({
  //  required this.id,
    required this.email,
    required this.userName,
  //  required this.fullName,
    required this.phone,
  });
  factory UserInfoModel.fromJson(jsonData) {
    return UserInfoModel(
  //    id: jsonData['data']['memberId']??jsonData['data']['companyId'],
      email: jsonData['data']['email'],
      userName: jsonData['data']['userName'],
   //   fullName: jsonData['data']['fullName']??jsonData['data']['companyName'],
      phone: jsonData['data']['phoneNumber'],
    );
  }
}
