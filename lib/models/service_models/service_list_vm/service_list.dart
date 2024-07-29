import 'package:freezed_annotation/freezed_annotation.dart';
part 'service_list.freezed.dart';
part 'service_list.g.dart';

@freezed
class ServiceListVM with _$ServiceListVM {
  const factory ServiceListVM({
    required String name,
    required int id,
    required double hourlyRate,
  }) = _ServiceListVM;
  const ServiceListVM._();

  factory ServiceListVM.fromJson(Map<String, dynamic> json) => _$ServiceListVMFromJson(json);
}
