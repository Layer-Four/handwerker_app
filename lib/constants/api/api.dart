import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
// Routes
  static const String _baseUrl = 'https://r-wa-happ-be.azurewebsites.net/api';
  static const String _getAllProjects = '/project/read/all';
  static const String _getListCustomer = '/customer/list';
  static const String _getAllTimeTacks = '/timetracking/read/all';
  static const String _getCustomerProject = '/customer/project/read/all';
  static const String _getMaterialsList = '/material/list';
  static const String _getProjectsAdress = '/project/list';
  static const String _getProjectsConsumable = '/userProjectMaterial/read/1';
  static const String _getServiceAdress = '/service/list';
  static const String _getTimeTacks = '/timetracking/read/3';
  static const String _getUserProjectDocumentation = '/userProjectDay/read/2';
  static const String _getProjectByCustomer = '/project/list?customerId=';
  static const String _postLoginUserAdress = '/user/login';
  static const String _postResetPasswordRequest = '/user/password/request/';

  static const String _postDocumentationDay = '/userProjectDay/create';
  static const String _postProjectConsumabele = '/userProjectMaterial/create';
  static const String _postTimeEntryAdress = '/timetracking/create';
  static const String _putChangePassword = '/user/password/change';
  // TODO: dont used
  static const String _putDocumentationDay = '/userProjectDay/update';
  static const String _putProjectMaterial = '/userProjectMaterial/update';

  static const String _getAllUnitsList = '/material/unit/list';
// Getter

  Future<Response> get getAllProjects => _api.get(_getAllProjects);
  Future<Response> get getListCustomer => _api.get(_getListCustomer);
  Future<Response> get getAllTimeentriesDM => _api.get(_getAllTimeTacks);
  Future<Response> get getAllUnits => _api.get(_getAllUnitsList);
  Future<Response> get getCustomerProjects => _api.get(_getCustomerProject);
  Future<Response> getDokuforProjectURL(int projectID) =>
      _api.get('/project/$projectID/documentations');

  Future<Response> get getExecuteableServices => _api.get(_getServiceAdress);
  Future<Response> get getMaterialsList => _api.get(_getMaterialsList);
  Future<Response> get getProjectsDM => _api.get(_getProjectsAdress);
  Future<Response> get getProjectConsumableEntry => _api.get(_getProjectsConsumable);
  Future<Response> get getProjectsTimeEntrys => _api.get(_getTimeTacks);
  Future<Response> get getUserDocumentationEntry => _api.get(_getUserProjectDocumentation);
  Future<Response> getProjectByCustomerID(int id) => _api.get('$_getProjectByCustomer$id');
  Future<Response> postloginUser(loginData) => _api.post(_postLoginUserAdress, data: loginData);

  Future<Response> postProjectConsumable(data) => _api.post(_postProjectConsumabele, data: data);
  Future<Response> postDocumentationEntry(FormData data) =>
      _api.post(_postDocumentationDay, data: data);
  Future<Response> postTimeEnty(data) => _api.post(_postTimeEntryAdress, data: data);
  Future<Response> setNewPassword(Map<String, dynamic> json) =>
      _api.put(_putChangePassword, data: json);
  Future<Response> putUpdateProjectConsumableEntry(data) =>
      _api.post(_putProjectMaterial, data: data);
  // TODO: dont used
  Future<Response> putpdateDocumentationEntry(data) => _api.post(_putDocumentationDay, data: data);
  Future<Response> postResetPasswordRequest(Map<String, dynamic> json) =>
      _api.post(_postResetPasswordRequest, data: json);
  void storeToken(String token) async => _storage.then(
        (e) => e.setString('TOKEN', token),
      ); //.write(key: 'TOKEN', value: token);
  void storeUserName(String name) async => _storage.then(
        (e) => e.setString('USERNAME', name),
      ); //.write(key: 'USERNAME', value: name);
  void storeMandant(String mandantID) async => _storage.then(
        (e) => e.setString('MANDANT', mandantID),
      ); //.write(key: 'MANDANT', value: mandantID);
  //  .then((e) => e.setString('TOKEN', token));
  void deleteToken() async => _storage.then(
        (e) => e.remove('TOKEN'),
      ); //.delete(key: 'TOKEN');
  void deleteMandant() async => _storage.then(
        (e) => e.remove('MANDANT'),
      ); //.delete(key: 'MANDANT');
  void deleteUserName() async => _storage.then(
        (e) => e.remove('USERNAME'),
      ); //.delete(key: 'userName');
  //  .then((e) => e.remove('TOKEN'));
  Future<String?> get getMandant async => _storage.then(
        (e) => e.getString('MANDANT'),
      ); //) .read(key: 'MANDANT');
  // Future<String?> get getMandant async => await _storage.read(key: 'MANDANT');
  Future<String?> get getUsername async => _storage.then(
        (e) => e.getString('USERNAME'),
      ); //.read(key: 'userName');
  Future<String?> get getToken async => _storage.then(
        (e) => e.getString('TOKEN'),
      ); //.read(key: 'TOKEN');
  // aOptions: _getAndroidOptions(),
  // iOptions: _getIOSOptions(),
  //((value) => value.getString('TOKEN'));
  // AndroidOptions _getAndroidOptions() => AndroidOptions();
  // IOSOptions _getIOSOptions([String accName = 'unDefin']) => IOSOptions(accountName: accName);
  final Dio _api = Dio();
  final _storage = SharedPreferences.getInstance();
  // final _storage = const FlutterSecureStorage();

  Api() {
    _api.options = BaseOptions(baseUrl: _baseUrl);

    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        final String? token = await getToken;
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
        if (error.response?.statusCode == 500 ||
            (error.message != null && error.message!.contains('500'))) {
          // deleteToken();P
          log('DB return $error');
        }
        // TODO: think about retry logic for wake up database
        if (error.response?.statusCode == 400) {
          // deleteToken();
          log('DB return ${error.response?.statusCode}\n ${error.response?.data}');
          // return handler.next(error);
        }

        return handler.next(error);
      },
    ));
  }
}
