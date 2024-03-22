import 'package:freezed_annotation/freezed_annotation.dart';
part 'service.freezed.dart';
part 'service.g.dart';

@freezed
class User with _$ServiceVM {
  const factory User({
    required String name,
    required int id,
  }) = _Service;

  factory User.fromJson(Map<String, dynamic> json) => _$ServiceVMFromJson(json);
}
