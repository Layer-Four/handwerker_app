// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeTrack _$TimeTrackFromJson(Map<String, dynamic> json) {
  return _TimeTrack.fromJson(json);
}

/// @nodoc
mixin _$TimeTrack {
  String get userId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  int? get projectId => throw _privateConstructorUsedError;
  int? get serviceId => throw _privateConstructorUsedError;
  String? get serviceTitle => throw _privateConstructorUsedError;
  String? get customerName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeTrackCopyWith<TimeTrack> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeTrackCopyWith<$Res> {
  factory $TimeTrackCopyWith(TimeTrack value, $Res Function(TimeTrack) then) =
      _$TimeTrackCopyWithImpl<$Res, TimeTrack>;
  @useResult
  $Res call(
      {String userId,
      int id,
      DateTime date,
      String? description,
      int? duration,
      int? projectId,
      int? serviceId,
      String? serviceTitle,
      String? customerName});
}

/// @nodoc
class _$TimeTrackCopyWithImpl<$Res, $Val extends TimeTrack>
    implements $TimeTrackCopyWith<$Res> {
  _$TimeTrackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? date = null,
    Object? description = freezed,
    Object? duration = freezed,
    Object? projectId = freezed,
    Object? serviceId = freezed,
    Object? serviceTitle = freezed,
    Object? customerName = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceTitle: freezed == serviceTitle
          ? _value.serviceTitle
          : serviceTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeTrackImplCopyWith<$Res>
    implements $TimeTrackCopyWith<$Res> {
  factory _$$TimeTrackImplCopyWith(
          _$TimeTrackImpl value, $Res Function(_$TimeTrackImpl) then) =
      __$$TimeTrackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int id,
      DateTime date,
      String? description,
      int? duration,
      int? projectId,
      int? serviceId,
      String? serviceTitle,
      String? customerName});
}

/// @nodoc
class __$$TimeTrackImplCopyWithImpl<$Res>
    extends _$TimeTrackCopyWithImpl<$Res, _$TimeTrackImpl>
    implements _$$TimeTrackImplCopyWith<$Res> {
  __$$TimeTrackImplCopyWithImpl(
      _$TimeTrackImpl _value, $Res Function(_$TimeTrackImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? date = null,
    Object? description = freezed,
    Object? duration = freezed,
    Object? projectId = freezed,
    Object? serviceId = freezed,
    Object? serviceTitle = freezed,
    Object? customerName = freezed,
  }) {
    return _then(_$TimeTrackImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceTitle: freezed == serviceTitle
          ? _value.serviceTitle
          : serviceTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeTrackImpl extends _TimeTrack {
  const _$TimeTrackImpl(
      {required this.userId,
      required this.id,
      required this.date,
      this.description,
      this.duration,
      this.projectId,
      this.serviceId,
      this.serviceTitle,
      this.customerName})
      : super._();

  factory _$TimeTrackImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeTrackImplFromJson(json);

  @override
  final String userId;
  @override
  final int id;
  @override
  final DateTime date;
  @override
  final String? description;
  @override
  final int? duration;
  @override
  final int? projectId;
  @override
  final int? serviceId;
  @override
  final String? serviceTitle;
  @override
  final String? customerName;

  @override
  String toString() {
    return 'TimeTrack(userId: $userId, id: $id, date: $date, description: $description, duration: $duration, projectId: $projectId, serviceId: $serviceId, serviceTitle: $serviceTitle, customerName: $customerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeTrackImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceTitle, serviceTitle) ||
                other.serviceTitle == serviceTitle) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, id, date, description,
      duration, projectId, serviceId, serviceTitle, customerName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeTrackImplCopyWith<_$TimeTrackImpl> get copyWith =>
      __$$TimeTrackImplCopyWithImpl<_$TimeTrackImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeTrackImplToJson(
      this,
    );
  }
}

abstract class _TimeTrack extends TimeTrack {
  const factory _TimeTrack(
      {required final String userId,
      required final int id,
      required final DateTime date,
      final String? description,
      final int? duration,
      final int? projectId,
      final int? serviceId,
      final String? serviceTitle,
      final String? customerName}) = _$TimeTrackImpl;
  const _TimeTrack._() : super._();

  factory _TimeTrack.fromJson(Map<String, dynamic> json) =
      _$TimeTrackImpl.fromJson;

  @override
  String get userId;
  @override
  int get id;
  @override
  DateTime get date;
  @override
  String? get description;
  @override
  int? get duration;
  @override
  int? get projectId;
  @override
  int? get serviceId;
  @override
  String? get serviceTitle;
  @override
  String? get customerName;
  @override
  @JsonKey(ignore: true)
  _$$TimeTrackImplCopyWith<_$TimeTrackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
