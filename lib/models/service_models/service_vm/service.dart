import 'package:freezed_annotation/freezed_annotation.dart';
part 'service.freezed.dart';
part 'service.g.dart';

@freezed
class ServiceVM with _$ServiceVM {
  const factory ServiceVM({
    required String name,
    required int id,
  }) = _Service;

  factory ServiceVM.fromJson(Map<String, dynamic> json) => _$ServiceVMFromJson(json);
}
