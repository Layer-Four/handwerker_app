import 'package:freezed_annotation/freezed_annotation.dart';
part 'material_vm.freezed.dart';
part 'material_vm.g.dart';

@freezed
class MaterialVM with _$MaterialVM {
  const factory MaterialVM({
    required String name,
    required int id,
  }) = _MaterialVM;

  factory MaterialVM.fromJson(Map<String, dynamic> json) => _$MaterialVMFromJson(json);
}
