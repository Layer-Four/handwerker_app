import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constants/api/api.dart';
import '../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../models/dokumentation_models/documentation_entry/documentation_entry.dart';
import '../../models/dokumentation_models/documentation_state/documentation_state.dart';
import '../../models/project_models/project_short_vm/project_short_vm.dart';
import '../settings_provider/user_provider.dart';

final documentationProvider = NotifierProvider<ProjectNotifer, DocumentationState>(
  () => ProjectNotifer(),
);

class ProjectNotifer extends Notifier<DocumentationState> {
  final Api _api = Api();
  @override
  DocumentationState build() {
    getAllCustomer();
    return const DocumentationState();
  }

  DocumentationEntry get doku => state.docu;
  ProjectShortVM? get project => state.project;
  List<ProjectShortVM> get projects => state.customerProject;
  CustomerShortDM? get currentCustomer => state.currentCustomer;
  List<CustomerShortDM>? get customers => state.customers;

  /// Load projects from Database and filtered with customerID.
  /// for Filtering give unnamed customerID and update DocumentationState.projects
  void getProjectForCustomer(int customerId) async {
    try {
      final response = await _api.getProjectByCustomerID(customerId);
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getProjectForCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      final projectsFromCustomer = data.map((e) => ProjectShortVM.fromJson(e)).toList();
      state = state.copyWith(newProjects: projectsFromCustomer);
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getProjectForCustomer: $e');
    }
    return;
  }

  Future<bool> createDocumentationEntry() async {
    if (state.docu.createDate == null) return false;
    final FormData formData = _buildFormData();
    try {
      final response = await _api.postDocumentationEntry(formData);
      if (response.statusCode != 200) {
        log('statuscode: ${response.statusCode}, backend returned: ${response.data}');
        throw Exception(
            'on postDocumentationEntry got statuscode: ${response.statusCode}\nbackend returned: ${response.data}');
      }
      log('request was successful-> ${response.data}');
      state = state.copyWith(
        editedCustomer: () => null,
        editedProject: () => null,
        editedDoc: const DocumentationEntry(),
      );
      return true;
    } on DioException catch (e) {
      log('DioException ${e.response!.statusCode} -> ${e.response!.data}');
    } catch (e) {
      if (e.toString().contains('500')) {
        ref.read(userProvider.notifier).userLogOut();
        log('userLogout on postDocumentationEntry \n${jsonEncode(e)}');
      }
      log('request was incompleted this was the error: $e');
    }
    return false;
  }

  /// Update project attribute from DocumentationState and edit document
  void updateProject(ProjectShortVM? e) {
    if (e == null || e == state.project) return;
    final oldDoc = state.docu;
    state = state.copyWith(
      editedProject: () => e,
      editedDoc: oldDoc.copyWith(projectID: e.id, projectName: e.title),
    );
  }

  /// Update DocumentationState.currentProject
  void updateProjectFromCustomer(List<ProjectShortVM> customerProjects) =>
      state = state.copyWith(newProjects: customerProjects);

  /// Update customers ttribute from DocumentationState.currentCustomer
  void updateCustomer(CustomerShortDM? e) {
    if (e == null || e == state.currentCustomer) return;
    getProjectForCustomer(e.id);
    state = state.copyWith(
      editedCustomer: () => e,
      editedProject: () => null,
    );
    return;
  }

  /// Load all Customers from Database and updated DocumentationStae.customers
  void getAllCustomer() async {
    try {
      final response = await _api.getListCustomer;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on getAllCustomer, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final result = <CustomerShortDM>[];
      response.data.map((e) => result.add(CustomerShortDM.fromJson(e))).toSet();
      state = state.copyWith(newCustomers: result);
    } on DioException catch (e) {
      log('DioException: ${e.message}');
    } catch (e) {
      log('Exception on getAllCustomer: $e');
    }
    return;
  }

  /// Update Documentation entry in DocumentationState object.
  updateDocumentation({
    DateTime? createDate,
    List<String>? imageUrl,
    Uint8List? newSignature,
    String? description,
  }) async {
    final newDoc = state.docu.copyWith(
      createDate: createDate ?? state.docu.createDate,
      projectID: project?.id,
      projectName: project?.title,
      imageUrl: imageUrl ?? state.docu.imageUrl,
      signature: newSignature != null ? String.fromCharCodes(newSignature) : state.docu.signature,
      description: description ?? state.docu.description,
    );
    state = state.copyWith(editedDoc: newDoc);
  }

  _buildFormData() {
    final entry = state.docu;
    final List<XFile> files = [];
    entry.imageUrl
        .map(
          (e) => files.add(
            XFile(
              e,
              name: '${entry.projectName}/${DateFormat('t.M.y').format(entry.createDate!)}',
            ),
          ),
        )
        .toList();
    if (entry.signature != null) {
      files.add(
        XFile.fromData(
          utf8.encode(entry.signature!),
          name: '${state.currentCustomer!.companyName}/signature.png',
          lastModified: DateTime.now(),
        ),
      );
    }
    // for (var path in entry.imageUrl) {
    //   final xfile = XFile(
    //     path,
    //     name: '${entry.projectName}/${DateFormat('t.M.y').format(entry.createDate!)}',
    //     mimeType: 'png',
    //   );
    //   xFileList.add(xfile);
    // }
    FormData formData = FormData.fromMap({
      'projectID': entry.projectID,
      'createDate': entry.createDate!.toIso8601String(),
      'description': entry.description,
    });

    formData.files.addAll(
      files.map(
        (e) => MapEntry(
          e.name,
          MultipartFile.fromFileSync(
            e.path,
            filename: '${state.project!.title}/${DateFormat('d.M.y').format(DateTime.now())}.png',
            // contentType: MediaType('image', 'png'),
            // contentType: MediaType.parse(e.mimeType ?? 'image/png'),
          ),
        ),
      ),
    );
    // for (var i = 0; i < files.length; i++) {
    //   final XFile file = files[i];
    //   try {
    //     final multiPartFile = MultipartFile.fromFileSync(
    //       file.path,
    //       filename: file.name,
    //       contentType: MediaType('image', 'png'),
    //     );
    //     formData.files.add(MapEntry('imageUrl${i == 0 ? "" : i}', multiPartFile));
    return formData;
    // } catch (e) {
    //   log('Error reading file: $e');
  }
}
