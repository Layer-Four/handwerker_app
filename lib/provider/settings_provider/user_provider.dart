import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_app/constants/api/api.dart';
// import 'package:handwerker_app/models/user.dart/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final userProvider =
//     NotifierProvider<UserNotifier, UserVM>(() => UserNotifier());

// // final authProvider = ChangeNotifierProvider<User>((ref) => User());

// class UserNotifier extends Notifier<UserVM> {
//   final Api api = Api();
//   final _storage = SharedPreferences.getInstance();
//   @override
//   UserVM build() {
//     String token = '';
//     _storage.then((value) {
//       final token = value.getString('TOKEN') ?? '';
//       if (token.isNotEmpty) {
//         state = state.copyWith(userToken: token);
//       }
//     });
//     return UserVM(userToken: token);
//   }

//   void userLogOut() {
//     state = state.copyWith(userToken: '');
//     deleteToken();
//   }

//   Future<String?> getUserToken() async {
//     final token = await _storage.then((value) => value.getString('TOKEN'));
//     if (token != null && token.isNotEmpty) {
//       state = state.copyWith(userToken: token);
//     }
//     return token;
//   }

// // TODO: delete default option for mandant
//   Future<bool> loginUser({
//     required String passwort,
//     required String userName,
//     String? mandatID,
//   }) async {
//     final Map<String, dynamic> json = {
//       "username": userName,
//       "password": passwort,
//       "mandant": mandatID ?? '1',
//     };
//     try {
//       final response = await api.postloginUser(json);
//       if (response.statusCode == 401) {
//         log('user not authorized');
//       }
//       if (response.statusCode == 200) {
//         @override
//         UserVM build() {
//           // TODO: implement build
//           throw UnimplementedError();
//         }

//         log(response.data.toString());
//         final data = (response.data as Map);
//         final userToken = data.values.first as String;
//         // TODO: when token Exist load user with Token
//         final newUser = state.copyWith(userToken: userToken);
//         setToken(token: userToken);
//         // final userDate = http.get('www.abc/getUerdata', data: userToken);

//         if (newUser != state) {
//           state = newUser;
//           return true;
//         }
//       } else {
//         log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
//         return false;
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//     return false;
//   }

//   Future<void> setToken({required String token}) async {
//     await _storage.then((value) => value.setString('TOKEN', token));
//   }

//   Future<void> deleteToken() async {
//     final storage = await SharedPreferences.getInstance();
//     if (storage.containsKey('TOKEN')) await storage.clear();
//   }
// }

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
