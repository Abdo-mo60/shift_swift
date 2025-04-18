import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/login/helper/local_network.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future<void> register({
    required String userName,
    required String email,
    required String password,
    required String phone,
    required String accountType,
  }) async {
    emit(RegisterLoadingState());
    String registerAccountType =
        (accountType == 'Member') ? 'RegisterMember' : 'RegisterCompany';
    try {
      http.Response response = await http.post(
        Uri.parse('$accountBaseUrl/$registerAccountType'),
        body: {
          'UserName': userName,
          'Email': email,
          'PhoneNumber': phone,
          'Password': password,
        },
      );
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['isSuccess'] == true) {
        await CacheNetwork.insertToCache(
          key: cacheTokenKey,
          value: responseBody['data']['token'],
        );
        token = responseBody['data']['token'];
        emit(RegisterSuccessState());
      } else {
        dynamic errorData = responseBody['data'];
        if (errorData is Map) {
          emit(FailedToRegisterState(errorMessage: errorData.toString()));
        } else if (errorData is List) {
          emit(FailedToRegisterState(errorMessage: errorData[0]));
        } else {
          emit(FailedToRegisterState(errorMessage: 'Unknown error'));
        }
      }
    } on Exception catch (e) {
    //  print('Error: $e');
      emit(
        FailedToRegisterState(
          errorMessage: 'An error occurred while registering.',
        ),
      );
    }
  }

  Future<void> login({
    required String userName,
    required String password,
    required String accountType,
  }) async {
    emit(LoginLoadingState());
    String loginAccountType =
        (accountType == 'Member') ? 'LoginMember' : 'LoginCompany';
    http.Response response = await http.post(
      Uri.parse('$accountBaseUrl/$loginAccountType'),
      body: jsonEncode({"userName": userName, "password": password}),
      headers: {'content-type': 'application/json'},
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
    //  print('tokenAfterLogin=>${responseBody['data']['token']}');
      await CacheNetwork.insertToCache(
        key: cacheTokenKey,
        value: responseBody['data']['token'],
      );
      token = responseBody['data']['token'];
    //  print('tokenAfterCacheSet=>$token');
      emit(LoginSuccessState());
    } else {
      List<dynamic> erorrData = responseBody['data'];
      emit(FailedTOLoginState(errorMessage: erorrData[0]));
    }
  }

  Future<void> logOut() async {
    http.Response response = await http.post(
      Uri.parse('$accountBaseUrl/LogOutAccoount'),
      headers: {'Authorization': 'Bearer $token'},
    );
  //  print('Log Out Response => ${response.statusCode}');

    if (response.statusCode == 200) {
      CacheNetwork.deleteCacheItem(key: cacheTokenKey);

      emit(LogOutStateSuccessfully());
    } else {
      emit(FailedToLogOutState());
    }
  }
}
