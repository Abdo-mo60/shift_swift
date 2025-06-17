import 'package:intl/intl.dart';

class ApplicantDetailsModel {
  final String memberId;
  final String userName;
  final String phoneNumber;
  final String email;
  String schoolName;
  String levelOfEducation;
  String fieldOfStudy;
   String ?title;
   String? description;
   String? postedOn;
  // dynamic experienceTitle;
  // dynamic experienceCompanyName;
  // dynamic experienceStartDate;
  // dynamic experienceEndDate;
  // dynamic experienceDescription;
  // dynamic skills;
  String? lastWorkCompanyPic;
  String? imageUrl;
  String? fullName;
  String?companyFirstName;
  String?companyLastName;
  String? location;
  // int? genderId;

  ApplicantDetailsModel({
    required this.memberId,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.schoolName,
    required this.levelOfEducation,
    required this.fieldOfStudy,
    required this.title,
    required this.description,
    required this.postedOn,

    // required this.experienceTitle,
    // required this.experienceCompanyName,
    // required this.experienceStartDate,
    // required this.experienceEndDate,
    // required this.experienceDescription,
    // this.skills,
    this.lastWorkCompanyPic,
    this.companyFirstName,
    this.companyLastName,
    this.fullName,
    this.location,
    this.imageUrl,
    //  this.genderId,
  });

  factory ApplicantDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final List educations = data['educations'];
    // final dynamic experienceList = data['experiences'];

    // final dynamic skillList = data['skills'];
    // dynamic getExperienceField(dynamic experienceList, String key) {

    //   return (experienceList is List&&  experienceList.isNotEmpty)
    //       ? experienceList[0][key]
    //       : []; // Return empty string if not found or empty list
    // }
    // dynamic getSkillField(dynamic skillList, String key) {
    //   return (skillList is List&&  skillList.isNotEmpty)
    //       ? skillList[0][key]
    //       : []; // Return empty string if not found or empty list
    // }
    String formattedDate;
    if(data['lastWorkInJob']!=null ){

      String dateString = data['lastWorkInJob']['postedOn'];
      DateTime date = DateTime.parse(dateString);
       formattedDate = DateFormat('MMMM d, y').format(date);
    }
    else {
       formattedDate='';
    }
    return ApplicantDetailsModel(
      
      memberId: data['memberId'],
      userName: data['userName'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      fullName: (data['fullName'] == ' ') ? data['userName'] : data['fullName'],
      location: (data['location'] == null) ? '' : data['location'],
      companyFirstName: (data['companyFirstName'] == null) ? '' : data['companyFirstName'],
      companyLastName: (data['companyLastName'] == null) ? '' : data['companyLastName'],
      lastWorkCompanyPic: (data['companyImageUrl'] == null) ? '' : data['companyImageUrl'],
      imageUrl: (data['memberImageUrl'] == null) ? '' : data['memberImageUrl'],
      schoolName: (educations.isEmpty) ? '' : educations[0]['universityName'],
      levelOfEducation: (educations.isEmpty) ? '' : educations[0]['level'],
      fieldOfStudy: (educations.isEmpty) ? '' : educations[0]['faculty'],
      title: (data['lastWorkInJob']==null )?'': data['lastWorkInJob']['title'],
      description:  (data['lastWorkInJob']==null )?'': data['lastWorkInJob']['description'],
      postedOn:  formattedDate,
      // experienceTitle: getExperienceField(experienceList, 'title'),
      // experienceCompanyName: getExperienceField(experienceList, 'companyName'),
      // experienceStartDate: getExperienceField(experienceList, 'startDate'),
      // experienceEndDate: getExperienceField(experienceList, 'endDate'),
      // experienceDescription: getExperienceField(experienceList, 'description'),
      // skills:getSkillField(skillList, 'name')

      //   fullName: data['fullName'] ?? '',
      // genderId: data['genderId'] ?? 0,
      // location: data['location'] ?? '',
      // answers: List<Map<String, dynamic>>.from(data['answers'] ?? []),
    );
  }
}
