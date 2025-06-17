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
      if (response.statusCode == 200) {
        await CacheNetwork.insertToCache(
          key: cacheTokenKey,
          value: responseBody['data']['token'],
        );
        token = responseBody['data']['token'];
        await CacheNetwork.insertToCache(
          key: cacheAccountTypeKey,
          value: accountType,
        );
        accType = accountType;
        if (accountType == 'Member') {
          await CacheNetwork.insertToCache(
            key: cacheMemberIdKey,
            value: responseBody['data']['memberResponse']['memberId'],
          );
          currentId = responseBody['data']['memberResponse']['memberId'];
        } else {
          await CacheNetwork.insertToCache(
            key: cacheMemberIdKey,
            value: responseBody['data']['companyResponse']['companyId'],
          );
          currentId = responseBody['data']['companyResponse']['companyId'];
        }
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
    }  catch (e) {
      //  print('Error: $e');
      emit(FailedToRegisterState(errorMessage: e.toString()));
    }
  }

  Future<void> login({
    required String userName,
    required String password,
    required String accountType,
  }) async {
    try {
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
        await CacheNetwork.insertToCache(
          key: cacheAccountTypeKey,
          value: accountType,
        );
        accType = accountType;
        if (accountType == 'Member') {
          await CacheNetwork.insertToCache(
            key: cacheMemberIdKey,
            value: responseBody['data']['memberResponse']['memberId'],
          );
          currentId = responseBody['data']['memberResponse']['memberId'];
        } else {
          await CacheNetwork.insertToCache(
            key: cacheCompanyIdKey,
            value: responseBody['data']['companyResponse']['companyId'],
          );
          currentId = responseBody['data']['companyResponse']['companyId'];
        }

        //  print('tokenAfterCacheSet=>$token');
        emit(LoginSuccessState());
      } else {
        List<dynamic> erorrData = responseBody['data'];
        emit(
          FailedTOLoginState(errorMessage: '${erorrData[0]}or Account Type'),
        );
      }
    } catch (e) {
      emit(FailedTOLoginState(errorMessage: e.toString()));
    }
  }

  Future<void> logOut() async {
    try {
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
    } catch (e) {
      emit(FailedToLogOutState());
    }
  }
}
