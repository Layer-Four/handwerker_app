import 'package:freezed_annotation/freezed_annotation.dart';

part 'execution.freezed.dart';
part 'execution.g.dart';

@freezed
class Execution with _$Execution {
  const factory Execution({
    String? executionID,
    String? projectID,
    required DateTime date,
    required String project,
    required DateTime timeStart,
    required DateTime timeEnd,
    DateTime? pasueStart,
    DateTime? pauseEnd,
    int? duration,
    String? service,
    @Default(<String>[]) List<String?> consumables,
    @Default(<String>[]) List<String?> usersID,
    String? descritpion,
  }) = _Execution;

  factory Execution.fromJson(Map<String, dynamic> json) => _$ExecutionFromJson(json);
}
