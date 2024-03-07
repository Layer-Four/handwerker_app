import 'package:flutter_riverpod/flutter_riverpod.dart';

final languangeProvider = StateProvider<Dictionary>((ref) => GermanLanguage());

abstract class Dictionary {
  String get createEntry;
  String get createPassword;
  String get customerProject;
  String get date;
  String get description;
  String get dokumentation;
  String get duration;
  String get end;
  String get enterPassword;
  String get enterUserName;
  String get forgetPassword;
  String get login;
  String get logout;
  String get project;
  String get start;
  String get service;
}

class GermanLanguage implements Dictionary {
  @override
  String get customerProject => 'KUNDE/PROJEKT';

  @override
  String get description => 'BESCHREIBUNG';

  @override
  String get enterUserName => 'Bitte gib dein Nutzternamen ein';

  @override
  String get createPassword => 'Erstelle neues Password';

  @override
  String get date => 'TAG';

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
  String get project => 'Projekt';

  @override
  String get logout => 'Ausloggen';

  @override
  String get start => 'VON';

  @override
  String get duration => 'DAUER';

  @override
  String get createEntry => 'Eintrag Erstellen';

  @override
  String get service => 'LEISTUNG';
}

class EnglishLanguage extends Dictionary {
  @override
  String get customerProject => 'COSTUMER/PROJECT';

  @override
  String get description => 'DESCRIPTION';

  @override
  String get enterUserName => 'Please enter your username';
  @override
  String get project => 'Project';

  @override
  String get createPassword => 'Create new password';

  @override
  String get date => 'DATE';

  @override
  String get dokumentation => 'DOCUMENTATION';

  @override
  String get end => 'END';

  @override
  String get enterPassword => 'Password';

  @override
  String get forgetPassword => 'Forgot password';

  @override
  String get login => 'LOGIN';

  @override
  //
  String get logout => 'LOGOUT';

  @override
  String get start => 'BEGIN';

  @override
  String get duration => 'DURATIOM';

  @override
  String get createEntry => 'New entry';

  @override
  String get service => 'SERVICE';
}
