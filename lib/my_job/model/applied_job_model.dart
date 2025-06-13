class AppliedJobModel {
  final String jobId;
  final String title;
  final String description;
  final String location;
  final DateTime postedOn;
  final String? companyPictureUrl;
  AppliedJobModel( {
    required this.jobId,
    required this.companyPictureUrl,
    required this.title,
    required this.description,
    required this.location,
    required this.postedOn,
  });
  factory AppliedJobModel.fromJson(Map<String, dynamic> json) {
    return AppliedJobModel(
      jobId: json['jobId'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      postedOn: DateTime.parse(json['postedOn'] as String),
      companyPictureUrl: json['companyPictureUrl'],
    );
  }
}
