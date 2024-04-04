import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = NotifierProvider<UserProvider, String?>(() {
  return UserProvider();
});

class UserProvider extends Notifier<String?> {
  @override
  String? build() => 'f7e8b09a-ac4f-4a30-a7c5-b6f829cff9aa';
  void userLogOut() {
    state = null;
  }
}
