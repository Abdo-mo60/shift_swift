class JobAddedModel {
  bool? isSuccess;
  int? statusCode;
  String? message;

  JobAddedModel({this.isSuccess, this.statusCode, this.message});

  factory JobAddedModel.fromJson(Map<String, dynamic> json) => JobAddedModel(
    isSuccess: json['isSuccess'] as bool?,
    statusCode: json['statusCode'] as int?,
    message: json['message'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'isSuccess': isSuccess,
    'statusCode': statusCode,
    'message': message,
  };
}
