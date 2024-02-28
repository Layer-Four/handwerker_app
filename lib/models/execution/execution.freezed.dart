// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'execution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Execution _$ExecutionFromJson(Map<String, dynamic> json) {
  return _Execution.fromJson(json);
}

/// @nodoc
mixin _$Execution {
  String? get executionID => throw _privateConstructorUsedError;
  String get project => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  String? get service => throw _privateConstructorUsedError;
  List<String>? get consumables => throw _privateConstructorUsedError;
  List<String>? get users => throw _privateConstructorUsedError;
  String? get descritpion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecutionCopyWith<Execution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutionCopyWith<$Res> {
  factory $ExecutionCopyWith(Execution value, $Res Function(Execution) then) =
      _$ExecutionCopyWithImpl<$Res, Execution>;
  @useResult
  $Res call(
      {String? executionID,
      String project,
      DateTime start,
      DateTime end,
      String? service,
      List<String>? consumables,
      List<String>? users,
      String? descritpion});
}

/// @nodoc
class _$ExecutionCopyWithImpl<$Res, $Val extends Execution>
    implements $ExecutionCopyWith<$Res> {
  _$ExecutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? executionID = freezed,
    Object? project = null,
    Object? start = null,
    Object? end = null,
    Object? service = freezed,
    Object? consumables = freezed,
    Object? users = freezed,
    Object? descritpion = freezed,
  }) {
    return _then(_value.copyWith(
      executionID: freezed == executionID
          ? _value.executionID
          : executionID // ignore: cast_nullable_to_non_nullable
              as String?,
      project: null == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      consumables: freezed == consumables
          ? _value.consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      descritpion: freezed == descritpion
          ? _value.descritpion
          : descritpion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExecutionImplCopyWith<$Res>
    implements $ExecutionCopyWith<$Res> {
  factory _$$ExecutionImplCopyWith(
          _$ExecutionImpl value, $Res Function(_$ExecutionImpl) then) =
      __$$ExecutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? executionID,
      String project,
      DateTime start,
      DateTime end,
      String? service,
      List<String>? consumables,
      List<String>? users,
      String? descritpion});
}

/// @nodoc
class __$$ExecutionImplCopyWithImpl<$Res>
    extends _$ExecutionCopyWithImpl<$Res, _$ExecutionImpl>
    implements _$$ExecutionImplCopyWith<$Res> {
  __$$ExecutionImplCopyWithImpl(
      _$ExecutionImpl _value, $Res Function(_$ExecutionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? executionID = freezed,
    Object? project = null,
    Object? start = null,
    Object? end = null,
    Object? service = freezed,
    Object? consumables = freezed,
    Object? users = freezed,
    Object? descritpion = freezed,
  }) {
    return _then(_$ExecutionImpl(
      executionID: freezed == executionID
          ? _value.executionID
          : executionID // ignore: cast_nullable_to_non_nullable
              as String?,
      project: null == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      consumables: freezed == consumables
          ? _value._consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      descritpion: freezed == descritpion
          ? _value.descritpion
          : descritpion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExecutionImpl implements _Execution {
  const _$ExecutionImpl(
      {this.executionID,
      required this.project,
      required this.start,
      required this.end,
      this.service,
      final List<String>? consumables,
      final List<String>? users,
      this.descritpion})
      : _consumables = consumables,
        _users = users;

  factory _$ExecutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExecutionImplFromJson(json);

  @override
  final String? executionID;
  @override
  final String project;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final String? service;
  final List<String>? _consumables;
  @override
  List<String>? get consumables {
    final value = _consumables;
    if (value == null) return null;
    if (_consumables is EqualUnmodifiableListView) return _consumables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _users;
  @override
  List<String>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? descritpion;

  @override
  String toString() {
    return 'Execution(executionID: $executionID, project: $project, start: $start, end: $end, service: $service, consumables: $consumables, users: $users, descritpion: $descritpion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExecutionImpl &&
            (identical(other.executionID, executionID) ||
                other.executionID == executionID) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.service, service) || other.service == service) &&
            const DeepCollectionEquality()
                .equals(other._consumables, _consumables) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.descritpion, descritpion) ||
                other.descritpion == descritpion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      executionID,
      project,
      start,
      end,
      service,
      const DeepCollectionEquality().hash(_consumables),
      const DeepCollectionEquality().hash(_users),
      descritpion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExecutionImplCopyWith<_$ExecutionImpl> get copyWith =>
      __$$ExecutionImplCopyWithImpl<_$ExecutionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExecutionImplToJson(
      this,
    );
  }
}

abstract class _Execution implements Execution {
  const factory _Execution(
      {final String? executionID,
      required final String project,
      required final DateTime start,
      required final DateTime end,
      final String? service,
      final List<String>? consumables,
      final List<String>? users,
      final String? descritpion}) = _$ExecutionImpl;

  factory _Execution.fromJson(Map<String, dynamic> json) =
      _$ExecutionImpl.fromJson;

  @override
  String? get executionID;
  @override
  String get project;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  String? get service;
  @override
  List<String>? get consumables;
  @override
  List<String>? get users;
  @override
  String? get descritpion;
  @override
  @JsonKey(ignore: true)
  _$$ExecutionImplCopyWith<_$ExecutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
