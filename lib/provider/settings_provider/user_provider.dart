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

  Future<String?> getToken() async => await _api.getToken;
  Future<bool> loginUser(String passwort, String userName, {String? mandantID = '1'}) async {
    try {
      final json = {"username": userName, "password": passwort, "mandant": mandantID};
      final response = await _api.postloginUser(json);
      if (response.statusCode != 200) {
        throw Exception('something went wrong status -> ${response.statusCode} : ${response.data}');
      }
      log(response.data.toString());
      final data = (response.data as Map);
      final userToken = data.values.first as String;
      _isOTP = response.data['oneTimePassword'];
      final newUser = state.copyWith(
        username: userName,
        userToken: userToken,
      );
      // TODO: Think about create a stored user with name or something else for later remote uses, No Password saving!!
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
      final response = await _api.postResetPasswordRequest(json, 'marten.meissner@layer-four.de');
      if (response.statusCode != 200) {
        throw Exception('Error on  resetPasswordRequest: ${response.statusCode}\n${response.data}');
      }
      log(response.data.toString());
    } on DioException catch (e) {
      throw Exception('DioExcption ${e.message}');
    } catch (e) {
      log('Error on resetPasswordRequest:\n$e');
    }
  }

  Future<bool> setNewPassword(String oldPW, String newPW) async {
    final json = {
      'userName': state.username,
      'oldPassword': oldPW,
      'newPassword': newPW,
    };
    log(jsonEncode(json));
    try {
      final response = await _api.setNewPassword(json);
      if (response.statusCode != 200) {
        throw Exception('Error on  resetPasswordRequest: ${response.statusCode}\n${response.data}');
      }
      log(response.data.toString());
      return true;
    } on DioException catch (e) {
      throw Exception('DioExcption ${e.message}');
    } catch (e) {
      log('Error on resetPasswordRequest:\n$e');
      return false;
    }
  }
}
