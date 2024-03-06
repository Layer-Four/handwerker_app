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
  String? get projectID => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get project => throw _privateConstructorUsedError;
  DateTime get timeStart => throw _privateConstructorUsedError;
  DateTime get timeEnd => throw _privateConstructorUsedError;
  DateTime? get pasueStart => throw _privateConstructorUsedError;
  DateTime? get pauseEnd => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  String? get service => throw _privateConstructorUsedError;
  List<String?> get consumables => throw _privateConstructorUsedError;
  List<String?> get usersID => throw _privateConstructorUsedError;
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
      String? projectID,
      DateTime date,
      String project,
      DateTime timeStart,
      DateTime timeEnd,
      DateTime? pasueStart,
      DateTime? pauseEnd,
      int? duration,
      String? service,
      List<String?> consumables,
      List<String?> usersID,
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
    Object? projectID = freezed,
    Object? date = null,
    Object? project = null,
    Object? timeStart = null,
    Object? timeEnd = null,
    Object? pasueStart = freezed,
    Object? pauseEnd = freezed,
    Object? duration = freezed,
    Object? service = freezed,
    Object? consumables = null,
    Object? usersID = null,
    Object? descritpion = freezed,
  }) {
    return _then(_value.copyWith(
      executionID: freezed == executionID
          ? _value.executionID
          : executionID // ignore: cast_nullable_to_non_nullable
              as String?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      project: null == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as String,
      timeStart: null == timeStart
          ? _value.timeStart
          : timeStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeEnd: null == timeEnd
          ? _value.timeEnd
          : timeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pasueStart: freezed == pasueStart
          ? _value.pasueStart
          : pasueStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      consumables: null == consumables
          ? _value.consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      usersID: null == usersID
          ? _value.usersID
          : usersID // ignore: cast_nullable_to_non_nullable
              as List<String?>,
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
      String? projectID,
      DateTime date,
      String project,
      DateTime timeStart,
      DateTime timeEnd,
      DateTime? pasueStart,
      DateTime? pauseEnd,
      int? duration,
      String? service,
      List<String?> consumables,
      List<String?> usersID,
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
    Object? projectID = freezed,
    Object? date = null,
    Object? project = null,
    Object? timeStart = null,
    Object? timeEnd = null,
    Object? pasueStart = freezed,
    Object? pauseEnd = freezed,
    Object? duration = freezed,
    Object? service = freezed,
    Object? consumables = null,
    Object? usersID = null,
    Object? descritpion = freezed,
  }) {
    return _then(_$ExecutionImpl(
      executionID: freezed == executionID
          ? _value.executionID
          : executionID // ignore: cast_nullable_to_non_nullable
              as String?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      project: null == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as String,
      timeStart: null == timeStart
          ? _value.timeStart
          : timeStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeEnd: null == timeEnd
          ? _value.timeEnd
          : timeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pasueStart: freezed == pasueStart
          ? _value.pasueStart
          : pasueStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      consumables: null == consumables
          ? _value._consumables
          : consumables // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      usersID: null == usersID
          ? _value._usersID
          : usersID // ignore: cast_nullable_to_non_nullable
              as List<String?>,
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
      this.projectID,
      required this.date,
      required this.project,
      required this.timeStart,
      required this.timeEnd,
      this.pasueStart,
      this.pauseEnd,
      this.duration,
      this.service,
      final List<String?> consumables = const <String>[],
      final List<String?> usersID = const <String>[],
      this.descritpion})
      : _consumables = consumables,
        _usersID = usersID;

  factory _$ExecutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExecutionImplFromJson(json);

  @override
  final String? executionID;
  @override
  final String? projectID;
  @override
  final DateTime date;
  @override
  final String project;
  @override
  final DateTime timeStart;
  @override
  final DateTime timeEnd;
  @override
  final DateTime? pasueStart;
  @override
  final DateTime? pauseEnd;
  @override
  final int? duration;
  @override
  final String? service;
  final List<String?> _consumables;
  @override
  @JsonKey()
  List<String?> get consumables {
    if (_consumables is EqualUnmodifiableListView) return _consumables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_consumables);
  }

  final List<String?> _usersID;
  @override
  @JsonKey()
  List<String?> get usersID {
    if (_usersID is EqualUnmodifiableListView) return _usersID;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usersID);
  }

  @override
  final String? descritpion;

  @override
  String toString() {
    return 'Execution(executionID: $executionID, projectID: $projectID, date: $date, project: $project, timeStart: $timeStart, timeEnd: $timeEnd, pasueStart: $pasueStart, pauseEnd: $pauseEnd, duration: $duration, service: $service, consumables: $consumables, usersID: $usersID, descritpion: $descritpion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExecutionImpl &&
            (identical(other.executionID, executionID) ||
                other.executionID == executionID) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.timeStart, timeStart) ||
                other.timeStart == timeStart) &&
            (identical(other.timeEnd, timeEnd) || other.timeEnd == timeEnd) &&
            (identical(other.pasueStart, pasueStart) ||
                other.pasueStart == pasueStart) &&
            (identical(other.pauseEnd, pauseEnd) ||
                other.pauseEnd == pauseEnd) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.service, service) || other.service == service) &&
            const DeepCollectionEquality()
                .equals(other._consumables, _consumables) &&
            const DeepCollectionEquality().equals(other._usersID, _usersID) &&
            (identical(other.descritpion, descritpion) ||
                other.descritpion == descritpion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      executionID,
      projectID,
      date,
      project,
      timeStart,
      timeEnd,
      pasueStart,
      pauseEnd,
      duration,
      service,
      const DeepCollectionEquality().hash(_consumables),
      const DeepCollectionEquality().hash(_usersID),
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
      final String? projectID,
      required final DateTime date,
      required final String project,
      required final DateTime timeStart,
      required final DateTime timeEnd,
      final DateTime? pasueStart,
      final DateTime? pauseEnd,
      final int? duration,
      final String? service,
      final List<String?> consumables,
      final List<String?> usersID,
      final String? descritpion}) = _$ExecutionImpl;

  factory _Execution.fromJson(Map<String, dynamic> json) =
      _$ExecutionImpl.fromJson;

  @override
  String? get executionID;
  @override
  String? get projectID;
  @override
  DateTime get date;
  @override
  String get project;
  @override
  DateTime get timeStart;
  @override
  DateTime get timeEnd;
  @override
  DateTime? get pasueStart;
  @override
  DateTime? get pauseEnd;
  @override
  int? get duration;
  @override
  String? get service;
  @override
  List<String?> get consumables;
  @override
  List<String?> get usersID;
  @override
  String? get descritpion;
  @override
  @JsonKey(ignore: true)
  _$$ExecutionImplCopyWith<_$ExecutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
