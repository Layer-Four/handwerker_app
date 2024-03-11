import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('') String userID,
    @Default('') String userToken,
    required String username,
    String? firstName,
    String? lastName,
    DateTime? hiringDate,
    DateTime? cancellationDate,
    String? email,
    String? profilePictureUrl,
    DateTime? dateOfBirth,
    String? address,
    String? phoneNumber,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
