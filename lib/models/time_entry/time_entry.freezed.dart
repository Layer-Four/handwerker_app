// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeEntry _$TimeEntryFromJson(Map<String, dynamic> json) {
  return _TimeEntry.fromJson(json);
}

/// @nodoc
mixin _$TimeEntry {
  DateTime get date => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  DateTime? get pauseEnd => throw _privateConstructorUsedError;
  DateTime? get pauseStart => throw _privateConstructorUsedError;
  String? get projectID => throw _privateConstructorUsedError;
  String? get service => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  String? get userID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeEntryCopyWith<TimeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeEntryCopyWith<$Res> {
  factory $TimeEntryCopyWith(TimeEntry value, $Res Function(TimeEntry) then) =
      _$TimeEntryCopyWithImpl<$Res, TimeEntry>;
  @useResult
  $Res call(
      {DateTime date,
      int? duration,
      String? description,
      DateTime? endTime,
      DateTime? pauseEnd,
      DateTime? pauseStart,
      String? projectID,
      String? service,
      DateTime startTime,
      String? userID});
}

/// @nodoc
class _$TimeEntryCopyWithImpl<$Res, $Val extends TimeEntry>
    implements $TimeEntryCopyWith<$Res> {
  _$TimeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? duration = freezed,
    Object? description = freezed,
    Object? endTime = freezed,
    Object? pauseEnd = freezed,
    Object? pauseStart = freezed,
    Object? projectID = freezed,
    Object? service = freezed,
    Object? startTime = null,
    Object? userID = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseStart: freezed == pauseStart
          ? _value.pauseStart
          : pauseStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userID: freezed == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeEntryImplCopyWith<$Res>
    implements $TimeEntryCopyWith<$Res> {
  factory _$$TimeEntryImplCopyWith(
          _$TimeEntryImpl value, $Res Function(_$TimeEntryImpl) then) =
      __$$TimeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int? duration,
      String? description,
      DateTime? endTime,
      DateTime? pauseEnd,
      DateTime? pauseStart,
      String? projectID,
      String? service,
      DateTime startTime,
      String? userID});
}

/// @nodoc
class __$$TimeEntryImplCopyWithImpl<$Res>
    extends _$TimeEntryCopyWithImpl<$Res, _$TimeEntryImpl>
    implements _$$TimeEntryImplCopyWith<$Res> {
  __$$TimeEntryImplCopyWithImpl(
      _$TimeEntryImpl _value, $Res Function(_$TimeEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? duration = freezed,
    Object? description = freezed,
    Object? endTime = freezed,
    Object? pauseEnd = freezed,
    Object? pauseStart = freezed,
    Object? projectID = freezed,
    Object? service = freezed,
    Object? startTime = null,
    Object? userID = freezed,
  }) {
    return _then(_$TimeEntryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseEnd: freezed == pauseEnd
          ? _value.pauseEnd
          : pauseEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pauseStart: freezed == pauseStart
          ? _value.pauseStart
          : pauseStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      projectID: freezed == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userID: freezed == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeEntryImpl implements _TimeEntry {
  const _$TimeEntryImpl(
      {required this.date,
      this.duration,
      this.description,
      this.endTime,
      this.pauseEnd,
      this.pauseStart,
      this.projectID,
      this.service,
      required this.startTime,
      this.userID});

  factory _$TimeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeEntryImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int? duration;
  @override
  final String? description;
  @override
  final DateTime? endTime;
  @override
  final DateTime? pauseEnd;
  @override
  final DateTime? pauseStart;
  @override
  final String? projectID;
  @override
  final String? service;
  @override
  final DateTime startTime;
  @override
  final String? userID;

  @override
  String toString() {
    return 'TimeEntry(date: $date, duration: $duration, description: $description, endTime: $endTime, pauseEnd: $pauseEnd, pauseStart: $pauseStart, projectID: $projectID, service: $service, startTime: $startTime, userID: $userID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeEntryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.pauseEnd, pauseEnd) ||
                other.pauseEnd == pauseEnd) &&
            (identical(other.pauseStart, pauseStart) ||
                other.pauseStart == pauseStart) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.userID, userID) || other.userID == userID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, duration, description,
      endTime, pauseEnd, pauseStart, projectID, service, startTime, userID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith =>
      __$$TimeEntryImplCopyWithImpl<_$TimeEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeEntryImplToJson(
      this,
    );
  }
}

abstract class _TimeEntry implements TimeEntry {
  const factory _TimeEntry(
      {required final DateTime date,
      final int? duration,
      final String? description,
      final DateTime? endTime,
      final DateTime? pauseEnd,
      final DateTime? pauseStart,
      final String? projectID,
      final String? service,
      required final DateTime startTime,
      final String? userID}) = _$TimeEntryImpl;

  factory _TimeEntry.fromJson(Map<String, dynamic> json) =
      _$TimeEntryImpl.fromJson;

  @override
  DateTime get date;
  @override
  int? get duration;
  @override
  String? get description;
  @override
  DateTime? get endTime;
  @override
  DateTime? get pauseEnd;
  @override
  DateTime? get pauseStart;
  @override
  String? get projectID;
  @override
  String? get service;
  @override
  DateTime get startTime;
  @override
  String? get userID;
  @override
  @JsonKey(ignore: true)
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}