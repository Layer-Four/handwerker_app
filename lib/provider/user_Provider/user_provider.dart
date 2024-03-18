import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/user.dart/user.dart';
import 'package:http/http.dart' as http;

final userProvider = NotifierProvider<UserNotifer, User>(() => UserNotifer());

class UserNotifer extends Notifier<User> {
  @override
  User build() => const User();
  void addProject(User user) => state = user;
  void userLogout() {
    final uri = Uri.parse('uri');
    final response = http.post(uri, body: state.userToken);
  }
}
