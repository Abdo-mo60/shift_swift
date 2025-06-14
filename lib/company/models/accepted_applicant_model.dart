class AcceptedApplicantModel {
  final String memberId;
  final String fullName;
  final String userName;
  final String phoneNumber;
  final String email;

  AcceptedApplicantModel({
    required this.memberId,
    required this.fullName,
    required this.userName,
    required this.phoneNumber,
    required this.email,
  });
  factory AcceptedApplicantModel.fromJson(applicant) {
 return   AcceptedApplicantModel(
      memberId: applicant['id'],
      fullName: applicant['fullName'],
      userName: applicant['userName'],
      phoneNumber: applicant['phoneNumber'],
      email: applicant['email'],
    );
  }
}
