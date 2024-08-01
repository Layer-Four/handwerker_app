import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/api/api.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/provider/settings_provider/user_provider.dart';

final materialVMProvider = AsyncNotifierProvider<MaterialNotifier, List<ConsumeableVM>>(() => MaterialNotifier());

class MaterialNotifier extends AsyncNotifier<List<ConsumeableVM>> {
  final Api api = Api();

  @override
  List<ConsumeableVM> build() => [];

  Future<List<ConsumeableVM>> loadMaterials() async {
    try {
      final response = await api.getMaterialsList;
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          ref.read(userProvider.notifier).userLogOut();
          return [];
        }
        log('request is not successful -> ${response.data}');
        return [];
      }
      final List data = response.data.map((e) => e as Map).toList();
      final materials = data.map((e) => ConsumeableVM.fromJson(e)).toList();
      return materials;
    } catch (e) {
      log('request was incomplete this was the error-> $e');
      return [];
    }
  }
}
