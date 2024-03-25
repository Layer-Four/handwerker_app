import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/url.dart';
import 'package:handwerker_app/models/user.dart/user.dart';

final userProvider =
    AsyncNotifierProvider<UserNotifier, User>(() => UserNotifier());

// final authProvider = ChangeNotifierProvider<User>((ref) => User());

class UserNotifier extends AsyncNotifier<User> {
  @override
  // ignore: prefer_const_constructors
  User build() => User();

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
    final path = const DbAdresses().postloginUser;

    final Dio http = Dio();
    try {
      final response = await http.post(path, data: json);
      if (response.statusCode == 200) {
        log(response.data.toString());
        final data = (response.data as Map);
        final userToken = data.values.first as String;
        final newUser = state.value?.copyWith(userToken: userToken);
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
}
