import 'package:intl/intl.dart';

class PersonalInfoModel {
  final String memberId;
  final String firstName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final String alternativeNumber;
  final String email;
  final String gender;
  final String country;
  final String level;
  final String faculty;
  final String universityName;
  final String city;
  final String area;
  final String birthDate;

  PersonalInfoModel({
    required this.memberId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
    required this.alternativeNumber,
    required this.email,
    required this.country,
    required this.city,
    required this.area,
    required this.level,
    required this.faculty,
    required this.universityName,
    required this.gender,
    required this.birthDate,
  });
  factory PersonalInfoModel.fromJson(json) {
    String formattedDate;
    if (json['data']['birthDate'] != null) {
      String dateString = json['data']['birthDate'];
      DateTime date = DateTime.parse(dateString);
      formattedDate = DateFormat('yyyy-MM-dd').format(date);
    } else {
      formattedDate = '';
    }
    final List educationList = json['data']['educations'];
    int genderValue = json['data']['genderId'];
    return PersonalInfoModel(
      memberId: json['data']['memberId'],
      firstName:
          (json['data']['firstName'] == null) ? '' : json['data']['firstName'],
      lastName:
          (json['data']['lastName'] == null) ? '' : json['data']['lastName'],
      userName: json['data']['userName'],
      phoneNumber: json['data']['phoneNumber'],
      alternativeNumber:
          (json['data']['alternativeNumber'] == null)
              ? ''
              : json['data']['alternativeNumber'],
      email: json['data']['email'],
      country:
          (json['data']['location'] == null) ? '' : json['data']['location'],
      city: (json['data']['city'] == null) ? '' : json['data']['city'],
      area: (json['data']['area'] == null) ? '' : json['data']['area'],
      birthDate: formattedDate,
      gender: GenderExtension.fromId(genderValue).name,
      level: (educationList.isEmpty) ? '' : educationList[0]['level'],
      faculty: (educationList.isEmpty) ? '' : educationList[0]['faculty'],
      universityName:
          (educationList.isEmpty) ? '' : educationList[0]['universityName'],
    );
  }
}

enum Gender { Male, Female, other }

extension GenderExtension on Gender {
  static Gender fromId(int id) {
    switch (id) {
      case 1:
        return Gender.Male;
      case 2:
        return Gender.Female;
      default:
        return Gender.other;
    }
  }

  String get name {
    switch (this) {
      case Gender.Male:
        return 'Male';
      case Gender.Female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }
}
