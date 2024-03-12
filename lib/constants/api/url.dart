class DbAdress {
  final String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  final String _serviceAdress = '/service/list';
  final String _projectsAdress = '/project/list';
  final String _timeTacksAdress = '/timetracking/read/3';
  final String _loginUser = '/user/login';

  const DbAdress();
  Uri get servicesUri => Uri.parse(_baseUrl + _serviceAdress);
  Uri get projects => Uri.parse(_baseUrl + _projectsAdress);
  Uri get timeEntrys => Uri.parse(_baseUrl + _timeTacksAdress);
  Uri get loginUser => Uri.parse(_baseUrl + _loginUser);
}
