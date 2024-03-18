// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProjectDay _$UserProjectDayFromJson(Map<String, dynamic> json) {
  return _UserProjectDay.fromJson(json);
}

/// @nodoc
mixin _$UserProjectDay {
  DateTime get date => throw _privateConstructorUsedError;
  String get documentationDescription => throw _privateConstructorUsedError;
  List<String> get filePaths => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProjectDayCopyWith<UserProjectDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProjectDayCopyWith<$Res> {
  factory $UserProjectDayCopyWith(
          UserProjectDay value, $Res Function(UserProjectDay) then) =
      _$UserProjectDayCopyWithImpl<$Res, UserProjectDay>;
  @useResult
  $Res call(
      {DateTime date, String documentationDescription, List<String> filePaths});
}

/// @nodoc
class _$UserProjectDayCopyWithImpl<$Res, $Val extends UserProjectDay>
    implements $UserProjectDayCopyWith<$Res> {
  _$UserProjectDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? documentationDescription = null,
    Object? filePaths = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      documentationDescription: null == documentationDescription
          ? _value.documentationDescription
          : documentationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      filePaths: null == filePaths
          ? _value.filePaths
          : filePaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProjectDayImplCopyWith<$Res>
    implements $UserProjectDayCopyWith<$Res> {
  factory _$$UserProjectDayImplCopyWith(_$UserProjectDayImpl value,
          $Res Function(_$UserProjectDayImpl) then) =
      __$$UserProjectDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date, String documentationDescription, List<String> filePaths});
}

/// @nodoc
class __$$UserProjectDayImplCopyWithImpl<$Res>
    extends _$UserProjectDayCopyWithImpl<$Res, _$UserProjectDayImpl>
    implements _$$UserProjectDayImplCopyWith<$Res> {
  __$$UserProjectDayImplCopyWithImpl(
      _$UserProjectDayImpl _value, $Res Function(_$UserProjectDayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? documentationDescription = null,
    Object? filePaths = null,
  }) {
    return _then(_$UserProjectDayImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      documentationDescription: null == documentationDescription
          ? _value.documentationDescription
          : documentationDescription // ignore: cast_nullable_to_non_nullable
              as String,
      filePaths: null == filePaths
          ? _value._filePaths
          : filePaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProjectDayImpl extends _UserProjectDay {
  const _$UserProjectDayImpl(
      {required this.date,
      this.documentationDescription = '',
      final List<String> filePaths = const <String>[]})
      : _filePaths = filePaths,
        super._();

  factory _$UserProjectDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProjectDayImplFromJson(json);

  @override
  final DateTime date;
  @override
  @JsonKey()
  final String documentationDescription;
  final List<String> _filePaths;
  @override
  @JsonKey()
  List<String> get filePaths {
    if (_filePaths is EqualUnmodifiableListView) return _filePaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filePaths);
  }

  @override
  String toString() {
    return 'UserProjectDay(date: $date, documentationDescription: $documentationDescription, filePaths: $filePaths)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProjectDayImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(
                    other.documentationDescription, documentationDescription) ||
                other.documentationDescription == documentationDescription) &&
            const DeepCollectionEquality()
                .equals(other._filePaths, _filePaths));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, documentationDescription,
      const DeepCollectionEquality().hash(_filePaths));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProjectDayImplCopyWith<_$UserProjectDayImpl> get copyWith =>
      __$$UserProjectDayImplCopyWithImpl<_$UserProjectDayImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProjectDayImplToJson(
      this,
    );
  }
}

abstract class _UserProjectDay extends UserProjectDay {
  const factory _UserProjectDay(
      {required final DateTime date,
      final String documentationDescription,
      final List<String> filePaths}) = _$UserProjectDayImpl;
  const _UserProjectDay._() : super._();

  factory _UserProjectDay.fromJson(Map<String, dynamic> json) =
      _$UserProjectDayImpl.fromJson;

  @override
  DateTime get date;
  @override
  String get documentationDescription;
  @override
  List<String> get filePaths;
  @override
  @JsonKey(ignore: true)
  _$$UserProjectDayImplCopyWith<_$UserProjectDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
