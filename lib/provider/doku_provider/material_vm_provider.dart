import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

final materialVMProvider =
    AsyncNotifierProvider<MaterialNotifier, List<MaterialVM>>(() => MaterialNotifier());

class MaterialNotifier extends AsyncNotifier<List<MaterialVM>> {
  final Api api = Api();

  @override
  List<MaterialVM> build() => [];

  void loadMaterials() async {
    // final materialUri = DbAdresses().getMaterialsList;
    // final Dio dio = Dio();
    try {
      // final response = await dio.get(materialUri);
      final response = await api.getMaterialsList;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return;
        }
        log('request is not successed -> ${response.data}');
        return;
      }
      final List data = response.data.map((e) => e as Map).toList();
      final materials = data.map((e) => MaterialVM.fromJson(e)).toList();
      state = AsyncValue.data(materials);
      return;
    } catch (e) {
      log('request was incompleted this was the error-> $e');
    }
  }
}
