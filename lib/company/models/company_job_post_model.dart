import 'package:intl/intl.dart';
import 'package:shiftswift/home/data/extension/job_type_extension.dart';
import 'package:shiftswift/home/data/extension/salary_type_extension.dart';

class CompanyJobPostModel {
  String? companyId;
  String? jobId;
  String? title;
  String? description;
  int? salary;
  String? salaryType;
  String? location;
  String? postedOn;
  String? jobType;
  String? workMode;
  String?requirements;
  String? keyWords;
  String? message;
  dynamic avgRatingScore;
  int? numberOfReviews;


  CompanyJobPostModel({
    this.companyId,
    this.jobId,
    this.title,
    this.description,
    this.location,
    this.postedOn,
    this.jobType,
    this.workMode,
    this.salary,
    this.salaryType,
    this.requirements,
    this.keyWords,
    this.message,
    this.avgRatingScore,
    this.numberOfReviews,
  });
  factory CompanyJobPostModel.fromJson({job,avgRating, numOfreviews}) {
    if (job is Map<String, dynamic>) {
        String formattedDate;
    if(job['postedOn']!=null ){

      String dateString = job['postedOn'];
      DateTime date = DateTime.parse(dateString);
       formattedDate = DateFormat('MMMM d, y').format(date);
    }
    else {
       formattedDate='';
    }
      return CompanyJobPostModel(
        companyId: job['companyId'],
        jobId: job['jobId'],
        title: job['title'],
        description: job['description'],
        location: job['location'],
        postedOn:formattedDate,
        jobType: JobTypeExtension.fromId(job['jobType']).name,
        workMode: WorkModeExtension.fromId(job['workMode']).name,
        salary: job['salary'] is num ? (job['salary'] as num).toInt():null,
        salaryType: SalaryTypeExtension.fromId(job['salaryType']).name,
        requirements: job['requirements'],
        keyWords: job['keywords'],
        avgRatingScore: avgRating,
        numberOfReviews:numOfreviews ,
      );
    } else if (job is List) {
      return CompanyJobPostModel(message: job[0]);
    } else {
      return CompanyJobPostModel(message: 'Unkown type of job list');
    }
  }
}
enum WorkMode { onSite, remotely, hybrid }

extension WorkModeExtension on WorkMode {
  static WorkMode fromId(int id) {
    switch (id) {
      case 1:
        return WorkMode.onSite;
      case 2:
        return WorkMode.remotely;
      default:
        return WorkMode.hybrid;
    }
  }

  String get name {
    switch (this) {
      case WorkMode.onSite:
        return 'On Site';
      case WorkMode.remotely:
        return 'Remotely';
      case WorkMode.hybrid:
        return 'Hybrid';
    }
  }
}
