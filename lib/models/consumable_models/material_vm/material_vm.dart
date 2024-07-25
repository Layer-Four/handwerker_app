import 'package:freezed_annotation/freezed_annotation.dart';

part 'material_vm.freezed.dart';
part 'material_vm.g.dart';

@freezed
class ConsumeableVM with _$ConsumeableVM {
  const factory ConsumeableVM({
    String? name,
    required int id,
    double? amount,
    double? price,
    String? unit,
  }) = _ConsumeableVM;

  factory ConsumeableVM.fromJson(Map<String, dynamic> json) => _$ConsumeableVMFromJson(json);
}
