class DbAdress {
  const DbAdress();
// BaseRoute
  final String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
// Routes
  final String _postProjectDay = '/userProjectDay/create';
  final String _getServiceAdress = '/service/list';
  final String _getProjectsAdress = '/project/list';
  final String _getTimeTacks = '/timetracking/read/3';
  final String _getAllTimeTacks = '/timetracking/read/all';
  final String _getProjectsConsumable = '/userProjectMaterial/read/1';
  final String _loginUserAdress = '/user/login';
  final String _postTimeEntryAdress = '/timetracking/create';
  final String _postProejctConsumabele = '/userProjectMaterial/create';
  final String _putProjectMaterial = '/userProjectMaterial/update';
  final String _getAllProjects = '/project/read/all';
  final String _putProjectDay = '/userProjectDay/update';
  final String _getUserProject = '/userProjectDay/read/2';
// Getter
  String get getProejctsTimeEntrys => _baseUrl + _getTimeTacks;
  String get getProjectConsumableEntry => _baseUrl + _getProjectsConsumable;
  String get getCostumerProjects => _baseUrl + _getProjectsAdress;
  String get getExecuteableServices => _baseUrl + _getServiceAdress;
  String get getAllTimeEntrys => _baseUrl + _getAllTimeTacks;
  String get getAllProjects => _baseUrl + _getAllProjects;
  String get postloginUser => _baseUrl + _loginUserAdress;
  String get postProjectConsumable => _baseUrl + _postProejctConsumabele;
  String get postProjectEntry => _baseUrl + _postProjectDay;
  String get postTimeEnty => _baseUrl + _postTimeEntryAdress;
  String get updateProjectConsumableEntry => _baseUrl + _putProjectMaterial;
  String get updateProjectEntry => _baseUrl + _putProjectDay;
  String get getUserProjectEntry => _baseUrl + _getUserProject;
}
