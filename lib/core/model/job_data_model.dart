import '../../home/data/enums/salary_type.dart';
import '../../home/data/extension/job_type_extension.dart';
import '../../home/data/extension/salary_type_extension.dart';

class JobDataModel {
  final String id;
  final String jobId;
  final String companyId;
  final String? companyFirstName;
  final String? companyLastName;
  final String title;
  final String description;
  final String requirements;
  final String location;
  final DateTime? postedOn;
  final SalaryType salaryTypeId;
  final double salary;
  final String? imageUrl;
  final String jobTypeTd;

  factory JobDataModel.fromJson(Map<String, dynamic> json) => JobDataModel(
    id: json['id'],
    jobId: json['jobId']??"",
    imageUrl: json['companyPictureUrl'] ?? "Unknown",
    companyId: json['companyId'],
    title: json['title'],
    description: json['description'],
    requirements: json['requirements']??"",
    location: json['location'],
    postedOn: DateTime.parse(json['postedOn'] ?? json['savedOn'] as String),
    salaryTypeId: SalaryTypeExtension.fromId(json['salaryTypeId']),
    salary: json['salary'],
    jobTypeTd: JobTypeExtension.fromId(json['jobTypeTd']).name,
    companyFirstName: json['companyFirstName'] ?? '',
    companyLastName: json['companyLastName'] ?? '',
  );

  JobDataModel({
    required this.companyLastName,
    required this.companyFirstName,
    required this.id,
    required this.jobId,
    required this.companyId,
    required this.title,
    required this.description,
    required this.location,
    required this.postedOn,
    required this.salaryTypeId,
    required this.salary,
    required this.jobTypeTd,
    required this.imageUrl,
    required this.requirements
  });
}
