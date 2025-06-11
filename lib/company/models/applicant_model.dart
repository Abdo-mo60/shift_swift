class ApplicantModel {
  final String memberId;
  final String fullName;
  // final String userName;
  final String phoneNumber;
  final String email;

  ApplicantModel({
    required this.memberId,
    required this.fullName,
    // required this.userName,
    required this.phoneNumber,
    required this.email,
  });
  factory ApplicantModel.fromJson(applicant) {
 return   ApplicantModel(
      memberId: applicant['memberId'],
      fullName: applicant['fullName'],
      // userName: applicant['userName'],
      phoneNumber: applicant['phoneNumber'],
      email: applicant['email'],
    );
  }
}
