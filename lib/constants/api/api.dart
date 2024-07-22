import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
// Routes
  static const String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  static const String _getAllProjects = '/project/read/all';
  static const String _getAllTimeTacks = '/timetracking/read/all';
  static const String _getCustomerProject = '/customer/project/read/all';
  static const String _getMaterialsList = '/material/list';
  static const String _getProjectsAdress = '/project/list';
  static const String _getProjectsConsumable = '/userProjectMaterial/read/1';
  static const String _getServiceAdress = '/service/list';
  static const String _getTimeTacks = '/timetracking/read/3';
  static const String _getUserProjectDocumentation = '/userProjectDay/read/2';
  static const String _postLoginUserAdress = '/user/login';
  static const String _postResetPasswordRequest = '/user/password/request/';
  static const String _postDocumentationDay = '/userProjectDay/create';
  static const String _postProjectConsumabele = '/userProjectMaterial/create';
  static const String _postTimeEntryAdress = '/timetracking/create';
  static const String _putChangePassword = '/user/password/change';
  static const String _putDocumentationDay = '/userProjectDay/update';
  static const String _putProjectMaterial = '/userProjectMaterial/update';

  static const String _getAllUnitsList = '/material/unit/list';
// Getter

  Future<Response> get getAllProjects => _api.get(_getAllProjects);
  Future<Response> get getAllTimeentriesDM => _api.get(_getAllTimeTacks);
  Future<Response> get getAllUnits => _api.get(_getAllUnitsList);
  Future<Response> get getCustomerProjects => _api.get(_getCustomerProject);
  Future<Response> getDokuforProjectURL(int projectID) => _api.get('/project/$projectID/documentations');

  Future<Response> get getExecuteableServices => _api.get(_getServiceAdress);
  Future<Response> get getMaterialsList => _api.get(_getMaterialsList);
  Future<Response> get getProjectsDM => _api.get(_getProjectsAdress);
  Future<Response> get getProjectConsumableEntry => _api.get(_getProjectsConsumable);
  Future<Response> get getProjectsTimeEntrys => _api.get(_getTimeTacks);
  Future<Response> get getUserDocumentationEntry => _api.get(_getUserProjectDocumentation);
  Future<Response> postloginUser(loginData) => _api.post(_postLoginUserAdress, data: loginData);

  Future<Response> postProjectConsumable(data) => _api.post(_postProjectConsumabele, data: data);
  Future<Response> postDocumentationEntry(data) => _api.post(_postDocumentationDay, data: data);
  Future<Response> postTimeEnty(data) => _api.post(_postTimeEntryAdress, data: data);
  Future<Response> setNewPassword(Map<String, dynamic> json) => _api.put(_putChangePassword, data: json);
  Future<Response> putUpdateProjectConsumableEntry(data) => _api.post(_putProjectMaterial, data: data);
  Future<Response> putpdateDocumentationEntry(data) => _api.post(_putDocumentationDay, data: data);
  Future<Response> postResetPasswordRequest(Map<String, dynamic> json) =>
      _api.post(_postResetPasswordRequest, data: json);
  void storeToken(String token) => _storage.then((e) => e.setString('TOKEN', token));
  void deleteToken() => _storage.then((e) => e.remove('TOKEN'));
  Future<String?> get getToken => _storage.then((value) => value.getString('TOKEN'));

  final Dio _api = Dio();

  final _storage = SharedPreferences.getInstance();
  Api() {
    _api.options = BaseOptions(baseUrl: _baseUrl);

    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        final token = await getToken;
        final accesMap = {'Authorization': 'Bearer $token'};
        options.headers.addEntries(accesMap.entries);

        if (!options.path.contains('http')) {
          options.path = _baseUrl + options.path;
        }
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 500 || (error.message != null && error.message!.contains('500'))) {
          _storage.then((value) => value.clear());
          log('message');
        }
        if (error.response?.statusCode == 400) {
          return;
        }

        return handler.next(error);
      },
    ));
  }
}
