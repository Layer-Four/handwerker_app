import 'package:freezed_annotation/freezed_annotation.dart';
part 'project_day.freezed.dart';
part 'project_day.g.dart';

@freezed
class UserProjectDay with _$UserProjectDay {
  const factory UserProjectDay({
    required DateTime date,
    @Default('') String documentationDescription,
    @Default(<String>[]) List<String> filePaths,
  }) = _UserProjectDay;

  const UserProjectDay._();
  factory UserProjectDay.fromJson(Map<String, dynamic> json) => _$UserProjectDayFromJson(json);
}
