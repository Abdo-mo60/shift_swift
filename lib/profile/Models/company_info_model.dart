import 'package:intl/intl.dart';

class CompanyInfoModel {
  final String companyId;
  final String firstName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final String email;
  final String overview;
  final String field;
  final String dateOfEstablish;
  final String country;
  final String city;
  final String area;

  CompanyInfoModel({
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.overview,
    required this.field,
    required this.dateOfEstablish,
    required this.country,
    required this.city,
    required this.area,
  });
  
  factory CompanyInfoModel.fromJson(json) {
     String formattedDate;
    if(json['data']['dateOfEstablish']!=null ){

      String dateString = json['data']['dateOfEstablish'];
      DateTime date = DateTime.parse(dateString);
       formattedDate = DateFormat('yyyy-MM-dd').format(date);
    }
    else {
       formattedDate='';
    }
    return CompanyInfoModel(
      companyId: json['data']['companyId'],
      firstName: (json['data']['firstName']==null)?'':json['data']['firstName'],
      lastName:(json['data']['lastName']==null)?'':json['data']['lastName'] ,
      userName: json['data']['userName'],
      phoneNumber: json['data']['phoneNumber'],
      email: json['data']['email'],
      overview: (json['data']['overview']==null)?'': json['data']['overview'],
      field: (json['data']['field']==null)?'': json['data']['field'],
      dateOfEstablish: formattedDate,
      country: (json['data']['country']==null)?'':json['data']['country'],
      city: (json['data']['city']==null)?'':json['data']['city'],
      area: (json['data']['area']==null)?'':json['data']['area'],
    );
  }
}
