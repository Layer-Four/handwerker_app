import 'package:freezed_annotation/freezed_annotation.dart';

part 'execution.freezed.dart';
part 'execution.g.dart';

@freezed
class Execution with _$Execution {
  const factory Execution({
    String? executionID,
    required String project,
    required DateTime start,
    required DateTime end,
    String? service,
    List<String>? consumables,
    List<String>? users,
    String? descritpion,
  }) = _Execution;

  factory Execution.fromJson(Map<String, dynamic> json) => _$ExecutionFromJson(json);
}
