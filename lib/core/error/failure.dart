import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: 'connection timeout with Api server',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'send timeout with Api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'recieve timeout with Api server');
      case DioExceptionType.badCertificate:
        return ServerFailure.fromResponse(dioException.response!.data);
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'connection Error');
      case DioExceptionType.unknown:
        return ServerFailure(errorMessage: 'Not Found');
    }
  }
  factory ServerFailure.fromResponse(dynamic response) {
    return ServerFailure(errorMessage: response['message']);
  }
}
