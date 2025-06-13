import 'package:dio/dio.dart';
class ApiService {
  final String _baseUrl = 'https://shiftswift.tryasp.net/api/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint,String? token}) async {
    var response = await _dio.get('$_baseUrl$endPoint',options: Options(
      headers: {
        'Authorization':'Bearer $token'
      }
    ));
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? body,  String? token,
  }) async {
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: body,
      options: Options(
        
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return response.data;
  }
}
