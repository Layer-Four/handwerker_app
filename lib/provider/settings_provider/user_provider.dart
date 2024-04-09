import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/user.dart/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = NotifierProvider<UserNotifier, UserVM>(() => UserNotifier());

// final authProvider = ChangeNotifierProvider<User>((ref) => User());

class UserNotifier extends Notifier<UserVM> {
  final Api api = Api();
  final _storage = SharedPreferences.getInstance();
  @override
  UserVM build() {
    String token = '';
    _storage.then((value) {
      final token = value.getString('TOKEN') ?? '';
      if (token.isNotEmpty) {
        state = state.copyWith(userToken: token);
      }
    });
    return UserVM(userToken: token);
  }

  void userLogOut() {
    state = state.copyWith(userToken: '');
    deleteToken();
  }

  Future<String?> getUserToken() async {
    final token = await _storage.then((value) => value.getString('TOKEN'));
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(userToken: token);
    }
    return token;
  }

// TODO: delete default option for mandant
  Future<bool> loginUser({
    required String passwort,
    required String userName,
    String? mandatID,
  }) async {
    final Map<String, dynamic> json = {
      "username": userName,
      "password": passwort,
      "mandant": mandatID ?? '1',
    };
    try {
      final response = await api.postloginUser(json);
      if (response.statusCode == 401) {
        log('user not authorized');
        return false;
      }
      if (response.statusCode == 200) {
        log(response.data.toString());
        final data = (response.data as Map);
        final userToken = data.values.first as String;
        // TODO: when token Exist load user with Token
        final newUser = state.copyWith(userToken: userToken);
        setToken(token: userToken);
        // final userDate = http.get('www.abc/getUerdata', data: userToken);

        if (newUser != state) {
          state = newUser;
          return true;
        }
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  void setToken({required String token}) async =>
      await _storage.then((value) => value.setString('TOKEN', token));
  void deleteToken() async {
    final storage = await _storage;
    if (storage.containsKey('TOKEN')) storage.clear();
    return;
  }
}
