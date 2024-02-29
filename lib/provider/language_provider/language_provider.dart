import 'package:flutter_riverpod/flutter_riverpod.dart';

final languangeProvider = StateProvider<Dictionary>((ref) => GermanLanguage());

abstract class Dictionary {
  String get enterUserName;
  String get enterPassword;
  String get date;
  String get start;
  String get end;
  String get dokumentation;
  String get logout;
  String get login;
  String get duration;
  String get forgetPassword;
  String get createPassword;
  String get createEntry;
}

class GermanLanguage implements Dictionary {
  @override
  String get enterUserName => 'Bitte gib dein Nutzternamen ein';

  @override
  String get createPassword => 'Erstelle neues Password';

  @override
  String get date => 'Tag';

  @override
  String get dokumentation => 'DOKUMENTATION';

  @override
  String get end => 'BIS';

  @override
  String get enterPassword => 'Password';

  @override
  String get forgetPassword => 'Passwort vergessen';

  @override
  String get login => 'Anmelden';

  @override
  String get logout => 'Ausloggen';

  @override
  String get start => 'VON';

  @override
  String get duration => 'DAUER';

  @override
  String get createEntry => 'Eintrag Erstellen';
}

class EnglishLanguage extends Dictionary {
  @override
  String get enterUserName => throw 'Please enter your username';

  @override
  // TODO: implement createPassword
  String get createPassword => throw UnimplementedError();

  @override
  // TODO: implement date
  String get date => 'DATE';

  @override
  // TODO: implement dokumentation
  String get dokumentation => throw UnimplementedError();

  @override
  // TODO: implement end
  String get end => throw UnimplementedError();

  @override
  // TODO: implement enterPassword
  String get enterPassword => throw UnimplementedError();

  @override
  // TODO: implement forgetPassword
  String get forgetPassword => throw UnimplementedError();

  @override
  // TODO: implement login
  String get login => throw UnimplementedError();

  @override
  // TODO: implement logout
  String get logout => throw UnimplementedError();

  @override
  // TODO: implement start
  String get start => throw UnimplementedError();

  @override
  // TODO: implement duration
  String get duration => 'DURATIOM';

  @override
  String get createEntry => 'new entry';
}
