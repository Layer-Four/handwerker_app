import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/user.dart/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider =
    AsyncNotifierProvider<UserNotifier, User?>(() => UserNotifier());

// final authProvider = ChangeNotifierProvider<User>((ref) => User());

class UserNotifier extends AsyncNotifier<User?> {
  final Api api = Api();
  final _storage = SharedPreferences.getInstance();
  @override

  // ignore: prefer_const_constructors
  User? build() => null;

  void userLogOut() {
    state = AsyncValue.data(null);
    deleteToken();
  }

  Future<String?> getUserToken() async =>
      _storage.then((value) => value.getString('TOKEN'));

// TODO: delete default option for mandant
  void loginUser({
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
      }
      if (response.statusCode == 200) {
        log(response.data.toString());
        final data = (response.data as Map);
        final userToken = data.values.first as String;
        // TODO: when token Exist load user with Token
        final newUser = state.value?.copyWith(userToken: userToken);
        setToken(token: userToken);
        // final userDate = http.get('www.abc/getUerdata', data: userToken);

        if (newUser != null) {
          state = AsyncValue.data(newUser);
          return;
        }
      } else {
        log('Request not completed: ${response.statusCode} Backend returned : ${response.data}  \n as Message');
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void setToken({required String token}) async =>
      await _storage.then((value) => value.setString('TOKEN', token));
  void deleteToken() async {
    final storage = await _storage;
    if (storage.containsKey('TOKEN')) storage.clear();
    return;
  }
}
