import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserVM with _$UserVM {
  const factory UserVM({
    @Default('') String userID,
    @Default('') String userToken,
    @Default('') String username,
    String? firstName,
    String? lastName,
    DateTime? hiringDate,
    DateTime? cancellationDate,
    String? email,
    String? profilePictureUrl,
    DateTime? dateOfBirth,
    String? address,
    String? phoneNumber,
  }) = _UserVM;

  factory UserVM.fromJson(Map<String, dynamic> json) => _$UserVMFromJson(json);
}
