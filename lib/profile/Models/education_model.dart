class EducationModel {
  final String? schoolName;
  final String? levelOfEducation;
  final String? fieldOfStudy;
  final String? message;
  EducationModel({
    this.schoolName,
    this.levelOfEducation,
    this.fieldOfStudy,
    this.message,
  });

  factory EducationModel.fromJson(json) {
    if (json['data'] is Map<String, dynamic>) {
      return EducationModel(
        schoolName: json['data']['schoolName'],
        levelOfEducation: json['data']['levelOfEducation'],
        fieldOfStudy: json['data']['fieldOfStudy'],
      );
    } else if (json['data'] is String) {
      return EducationModel(message: json['data']);
    } else {
      return EducationModel(message: 'unexpected format');
    }
  }
}
