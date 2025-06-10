class LastWorkModel {
  String? jobId;
  String? title;
  String? description;
  String? location;
  num? salary;
  DateTime? postedOn;
  String? requirements;
  String? keywords;
  String? companyId;
  dynamic firstName;
  dynamic lastName;
  dynamic companyPictureUrl;

  LastWorkModel({
    this.jobId,
    this.title,
    this.description,
    this.location,
    this.salary,
    this.postedOn,
    this.requirements,
    this.keywords,
    this.companyId,
    this.firstName,
    this.lastName,
    this.companyPictureUrl,
  });

  factory LastWorkModel.fromJson(Map<String, dynamic> json) => LastWorkModel(
    jobId: json['jobId'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    location: json['location'] as String?,
    salary: json['salary'] as num?,
    postedOn:
        json['postedOn'] == null
            ? null
            : DateTime.parse(json['postedOn'] as String),
    requirements: json['requirements'] as String?,
    keywords: json['keywords'] as String?,
    companyId: json['companyId'] as String?,
    firstName: json['firstName'] as dynamic,
    lastName: json['lastName'] as dynamic,
    companyPictureUrl: json['companyPictureUrl'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'jobId': jobId,
    'title': title,
    'description': description,
    'location': location,
    'salary': salary,
    'postedOn': postedOn?.toIso8601String(),
    'requirements': requirements,
    'keywords': keywords,
    'companyId': companyId,
    'firstName': firstName,
    'lastName': lastName,
    'companyPictureUrl': companyPictureUrl,
  };
}
