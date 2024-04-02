class DbAdresses {
  // BaseRoute
  final String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
// Routes
  final String _getAllProjects = '/project/read/all';
  final String _getAllTimeTacks = '/timetracking/read/all';
  final String _getProjectsAdress = '/project/list';
  final String _getProjectsConsumable = '/userProjectMaterial/read/1';
  final String _getServiceAdress = '/service/list';
  final String _getTimeTacks = '/timetracking/read/3';
  final String _getUserProjectDocumentation = '/userProjectDay/read/2';
  final String _loginUserAdress = '/user/login';
  final String _postDocumentationDay = '/userProjectDay/create';
  final String _postTimeEntryAdress = '/timetracking/create';
  final String _postProjectConsumabele = '/userProjectMaterial/create';
  final String _putDocumentationDay = '/userProjectDay/update';
  final String _putProjectMaterial = '/userProjectMaterial/update';
  final String _getCustomerProject = '/customer/project/read/all';
  final String _getMaterialsList = '/material/list';
  const DbAdresses();
// Getter
  String get getAllProjects => _baseUrl + _getAllProjects;
  String get getAllTimeEntrys => _baseUrl + _getAllTimeTacks;
  String get getProjectsDM => _baseUrl + _getProjectsAdress;
  String get getCustomerProjects => _baseUrl + _getCustomerProject;
  String get getExecuteableServices => _baseUrl + _getServiceAdress;
  String get getMaterialsList => _baseUrl + _getMaterialsList;
  String get getProjectConsumableEntry => _baseUrl + _getProjectsConsumable;
  String get getProjectsTimeEntrys => _baseUrl + _getTimeTacks;
  String get getUserDocumentationEntry => _baseUrl + _getUserProjectDocumentation;
  String get postloginUser => _baseUrl + _loginUserAdress;
  String get postProjectConsumable => _baseUrl + _postProjectConsumabele;
  String get postDocumentationEntry => _baseUrl + _postDocumentationDay;
  String get postTimeEnty => _baseUrl + _postTimeEntryAdress;
  String get updateProjectConsumableEntry => _baseUrl + _putProjectMaterial;
  String get updateDocumentationEntry => _baseUrl + _putDocumentationDay;

  String getDokuforProjectURL(int projectID) => '$_baseUrl/project/$projectID/documentations';
}
