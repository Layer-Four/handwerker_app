import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/user.dart/user.dart';

final userProvider = NotifierProvider<UserNotifier, UserVM>(() => UserNotifier());

// final authProvider = ChangeNotifierProvider<User>((ref) => User());

class UserNotifier extends Notifier<UserVM> {
  final Api _api = Api();
  bool _isOTP = false;
  bool get isOneTimePassword => _isOTP;
  @override
  UserVM build() {
    _api.getToken.then((value) {
      if (value != null) {
        state = state.copyWith(userToken: value);
      }
    });
    return const UserVM(userToken: '');
  }

  void userLogOut() {
    state = state.copyWith(userToken: '');
    return _api.deleteToken();
  }

  /// return token from API object
  Future<String?> getToken() async => await _api.getToken;

  /// called API and request a [String] userNamen and a [String] password, also it exist a property mandandID for diffenrent mandanten
  Future<bool> loginUser(
      {required password, required String userName, String? mandantID = '1'}) async {
    final json = {
      "username": '$mandantID$userName',
      "password": password,
      // "mandant": mandantID,
    };

    try {
      final response = await _api.postloginUser(json);
      if (response.statusCode != 200) {
        throw Exception('something went wrong status -> ${response.statusCode} : ${response.data}');
      }
      log(response.data.toString());
      _api.storeToken(response.data['token']);
      final userToken = response.data['token'];
      _isOTP = response.data['oneTimePassword'];
      final newUser = state.copyWith(
        username: userName,
        userToken: userToken,
      );
      _api.storeToken(userToken);
      if (newUser != state) state = newUser;
      return true;
    } on DioException catch (e) {
      if (e.message!.contains('401')) {
        log('user Input is not correct');
        return false;
      }
      throw Exception('DioExcption ${e.message}');
    } catch (e) {
      log('user Input is not correct');
      return false;
    }
  }

  void resetPasswordRequest(String username) async {
    final json = {"mandantID": 1, "userName": username};
    try {
      final response = await _api.postResetPasswordRequest(json);
      if (response.statusCode != 200) {
        throw Exception('Error on  resetPasswordRequest: ${response.statusCode}\n${response.data}');
      }
      // log(response.data.toString());
    } on DioException catch (e) {
      log('DioExcption ${e.message}');
    } catch (e) {
      log('Error on resetPasswordRequest:\n$e');
    }
  }

  Future<bool> setNewPassword(String oldPW, String newPW) async {
    final json = {'userName': state.username, 'oldPassword': oldPW, 'newPassword': newPW};
    log(jsonEncode(json));
    try {
      final response = await _api.setNewPassword(json);
      if (response.statusCode != 200) {
        throw Exception('Error on  resetPasswordRequest: ${response.statusCode}\n${response.data}');
      }
      log(response.data.toString());
      return true;
    } on DioException catch (e) {
      log('DioExcption ${e.message}');
    } catch (e) {
      log('Error on resetPasswordRequest:\n$e');
    }
    return false;
  }
}
