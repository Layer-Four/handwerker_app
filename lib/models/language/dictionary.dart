abstract class Dictionary {
  const Dictionary();
  String get amount;
  String get changeLanguage;
  String get changePassword;
  String get checkInput;
  String get choosedImage;
  String get consumables;
  String get createEntry;
  String get createPassword;
  String get customerProject;
  String get darkMode;
  String get date;
  String get description;
  String get documentationLabel;
  String get dokumentation;
  String get duration;
  String get end;
  String get english;
  String get enterPassword;
  String get enterUserName;
  String get estimatedDuration;
  String get failed;
  String get forgetPassword;
  String get german;
  String get lightTheme;
  String get login;
  String get logout;
  String get logUserOut;
  String get makePicture;
  String get material;
  String get overView;
  String get ownLanguage;
  String get pictureSucces;
  String get plsChooseBeginEnd;
  String get plsChooseCustomerService;
  String get plsChooseDay;
  String get plsChooseProject;
  String get plsEnterUserName;
  String get project;
  String get projectName;
  String get service;
  String get sessionHasEnded;

  String get start;

  String get succes;

  String get sum;

  String get takePicture;

  String get taskOverview;

  String get themeModeSystem;

  String get timeoverview;

  String get workOrder;

  String get loadData;
}

class EnglishLanguage extends Dictionary {
  const EnglishLanguage();
  @override
  String get amount => 'AMOUNT';

  @override
  String get changeLanguage => 'Languages';

  @override
  String get changePassword => 'Change Passowrd';

  @override
  String get checkInput => 'Please check your input';
  @override
  String get choosedImage => 'choosed image';

  @override
  String get consumables => 'Consumbales';

  @override
  String get createEntry => 'New entry';

  @override
  String get createPassword => 'Create new password';

  @override
  String get customerProject => 'COSTUMER/PROJECT';

  @override
  get darkMode => 'Darkmode';

  @override
  String get date => 'DATE';

  @override
  String get description => 'DESCRIPTION';

  @override
  String get documentationLabel => 'Documentation';

  @override
  String get dokumentation => 'DOCUMENTATION';

  @override
  String get duration => 'DURATIOM';

  @override
  String get end => 'END';

  @override
  String get english => 'English';

  @override
  String get enterPassword => 'Password';

  @override
  String get enterUserName => 'Please enter your username';

  @override
  String get estimatedDuration => 'estimated duration';

  @override
  String get failed => 'Failed';

  @override
  String get forgetPassword => 'Forgot password';

  @override
  String get german => 'German';

  @override
  get lightTheme => 'Lightmode';

  @override
  String get login => 'LOGIN';

  @override
  String get logout => 'LOGOUT';

  @override
  String get logUserOut => 'Log out user';

  @override
  String get makePicture => 'make a pciture';

  @override
  String get material => 'MATERIAL';

  @override
  String get overView => 'OVERVIEW';

  @override
  String get ownLanguage => 'English';

  @override
  String get pictureSucces => ' picked picture';

  @override
  String get plsChooseBeginEnd => 'Please select a begin and end time';

  @override
  String get plsChooseCustomerService => 'please choose CUSTOMER/PROJECT and SERVICE';

  @override
  String get plsChooseDay => 'Please choose a Date';

  @override
  String get plsChooseProject => 'Please choose a project';

  @override
  String get plsEnterUserName => 'Please enter your email';

  @override
  String get project => 'Project';

  @override
  String get projectName => 'Projectname';

  @override
  String get service => 'SERVICE';

  @override
  String get sessionHasEnded => 'Your session has ended.\nPlease login again';

  @override
  String get start => 'BEGIN';

  @override
  String get succes => 'Success';

  @override
  String get sum => 'SUM';

  @override
  String get takePicture => 'take a pciture';

  @override
  String get taskOverview => 'Jobs';

  @override
  get themeModeSystem => 'Systemmode';

  @override
  String get timeoverview => 'Timeoverview';

  @override
  String get workOrder => 'Work order';

  @override
  String get loadData => 'Load data...';
}

class GermanLanguage extends Dictionary {
  const GermanLanguage();
  @override
  String get amount => 'MENGE';
  @override
  String get changeLanguage => 'Sprachen';

  @override
  String get changePassword => 'Password ändern';

  @override
  String get checkInput => 'Bitte Kontrolliere deine Eingaben';

  @override
  String get choosedImage => 'Bild ausgewählt';

  @override
  String get consumables => 'Material';

  @override
  String get createEntry => 'Eintrag erstellen';

  @override
  String get createPassword => 'Erstelle neues Password';

  @override
  String get customerProject => 'KUNDE/PROJEKT';

  @override
  get darkMode => 'Dunkel';

  @override
  String get date => 'TAG';

  @override
  String get description => 'BESCHREIBUNG';

  @override
  String get documentationLabel => 'Dokumentation';

  @override
  String get dokumentation => 'DOKUMENTATION';

  @override
  String get duration => 'DAUER';

  @override
  String get end => 'BIS';

  @override
  String get english => 'Englisch';

  @override
  String get enterPassword => 'Password';
  @override
  String get enterUserName => 'Bitte gib dein Nutzternamen ein';

  @override
  String get estimatedDuration => 'Geschätze Dauer';
  @override
  String get failed => 'Fehlgeschlagen';

  @override
  String get forgetPassword => 'Passwort vergessen';

  @override
  String get german => 'Deutsch';

  @override
  get lightTheme => 'Hell';

  @override
  String get login => 'Anmelden';

  @override
  String get logout => 'Ausloggen';

  @override
  String get logUserOut => 'Nutzer abmelden';

  @override
  String get makePicture => 'Foto machen';

  @override
  String get material => 'MATERIAL';

  @override
  String get overView => 'ÜBERSICHT';

  @override
  String get ownLanguage => 'Deutsch';

  @override
  String get pictureSucces => ' Bild ausgewählt';

  @override
  String get plsChooseBeginEnd => 'Bitte gib Start und eine Endzeit an';

  @override
  String get plsChooseCustomerService => 'Bitte wähle ein KUNDE/PROJEKT und LEISTUNG aus';

  @override
  String get plsChooseDay => 'Bitte wähle ein anderes Datum';

  @override
  String get plsChooseProject => 'Bitte wähle einen Kunde und Projekt';

  @override
  String get plsEnterUserName => 'Bitte geb dein Nutzernamen ein ';

  @override
  String get project => 'Projekt';

  @override
  String get projectName => 'Projektname';

  @override
  String get service => 'LEISTUNG';

  @override
  String get sessionHasEnded => 'Ihre Sitzung wurde Beendet.\nBitte melden sie sich erneut an';

  @override
  String get start => 'VON';

  @override
  String get succes => 'Erstellt!';

  @override
  String get sum => 'SUMME';

  @override
  String get takePicture => 'Bild wählen';

  @override
  String get taskOverview => 'Aufträge';

  @override
  get themeModeSystem => 'System';

  @override
  String get timeoverview => 'Zeitübersicht';

  @override
  String get workOrder => 'Aufträge';

  @override
  String get loadData => 'Lade Daten...';
}
