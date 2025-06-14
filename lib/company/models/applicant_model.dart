class ApplicantModel {
  final String memberId;
  final String fullName;
  final String userName;
  final int status;
  final String phoneNumber;
  final String email;
  final String location;
  String schoolName;
  String levelOfEducation;
  String fieldOfStudy;
  String? memberImageUrl;

  ApplicantModel({
    required this.memberId,
    required this.fullName,
    required this.userName,
    required this.status,
    required this.phoneNumber,
    required this.email,
    required this.schoolName,
    required this.fieldOfStudy,
    required this.location,
    required this.levelOfEducation,
    this.memberImageUrl,
  });
  factory ApplicantModel.fromJson(applicant) {
    final List educations = applicant['educations'];

    return ApplicantModel(
      memberId: applicant['memberId'],
      fullName: applicant['fullName'],
      userName: applicant['userName'],
      status: applicant['status'],
      phoneNumber: applicant['phoneNumber'],
      email: applicant['email'],
      location: applicant['location'],
      schoolName: (educations.isEmpty) ? '' : educations[0]['universityName'],
      levelOfEducation: (educations.isEmpty) ? '' : educations[0]['level'],
      fieldOfStudy: (educations.isEmpty) ? '' : educations[0]['faculty'],
      memberImageUrl:
          (applicant['memberImageUrl'] == null)
              ? ''
              : applicant['memberImageUrl'],
    );
  }
}
