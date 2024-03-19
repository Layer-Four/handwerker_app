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

ProjectTimeVM _$ProjectTimeVMFromJson(Map<String, dynamic> json) {
  return _ProjectTimeVM.fromJson(json);
}

/// @nodoc
mixin _$ProjectTimeVM {
  int? get durationTotal => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  int get serviceID => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectTimeVMCopyWith<ProjectTimeVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectTimeVMCopyWith<$Res> {
  factory $ProjectTimeVMCopyWith(
          ProjectTimeVM value, $Res Function(ProjectTimeVM) then) =
      _$ProjectTimeVMCopyWithImpl<$Res, ProjectTimeVM>;
  @useResult
  $Res call(
      {int? durationTotal,
      DateTime end,
      int serviceID,
      String serviceName,
      DateTime start});
}

/// @nodoc
class _$ProjectTimeVMCopyWithImpl<$Res, $Val extends ProjectTimeVM>
    implements $ProjectTimeVMCopyWith<$Res> {
  _$ProjectTimeVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationTotal = freezed,
    Object? end = null,
    Object? serviceID = null,
    Object? serviceName = null,
    Object? start = null,
  }) {
    return _then(_value.copyWith(
      durationTotal: freezed == durationTotal
          ? _value.durationTotal
          : durationTotal // ignore: cast_nullable_to_non_nullable
              as int?,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serviceID: null == serviceID
          ? _value.serviceID
          : serviceID // ignore: cast_nullable_to_non_nullable
              as int,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectTimeVMImplCopyWith<$Res>
    implements $ProjectTimeVMCopyWith<$Res> {
  factory _$$ProjectTimeVMImplCopyWith(
          _$ProjectTimeVMImpl value, $Res Function(_$ProjectTimeVMImpl) then) =
      __$$ProjectTimeVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? durationTotal,
      DateTime end,
      int serviceID,
      String serviceName,
      DateTime start});
}

/// @nodoc
class __$$ProjectTimeVMImplCopyWithImpl<$Res>
    extends _$ProjectTimeVMCopyWithImpl<$Res, _$ProjectTimeVMImpl>
    implements _$$ProjectTimeVMImplCopyWith<$Res> {
  __$$ProjectTimeVMImplCopyWithImpl(
      _$ProjectTimeVMImpl _value, $Res Function(_$ProjectTimeVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationTotal = freezed,
    Object? end = null,
    Object? serviceID = null,
    Object? serviceName = null,
    Object? start = null,
  }) {
    return _then(_$ProjectTimeVMImpl(
      durationTotal: freezed == durationTotal
          ? _value.durationTotal
          : durationTotal // ignore: cast_nullable_to_non_nullable
              as int?,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serviceID: null == serviceID
          ? _value.serviceID
          : serviceID // ignore: cast_nullable_to_non_nullable
              as int,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectTimeVMImpl extends _ProjectTimeVM {
  const _$ProjectTimeVMImpl(
      {this.durationTotal,
      required this.end,
      required this.serviceID,
      required this.serviceName,
      required this.start})
      : super._();

  factory _$ProjectTimeVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectTimeVMImplFromJson(json);

  @override
  final int? durationTotal;
  @override
  final DateTime end;
  @override
  final int serviceID;
  @override
  final String serviceName;
  @override
  final DateTime start;

  @override
  String toString() {
    return 'ProjectTimeVM(durationTotal: $durationTotal, end: $end, serviceID: $serviceID, serviceName: $serviceName, start: $start)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectTimeVMImpl &&
            (identical(other.durationTotal, durationTotal) ||
                other.durationTotal == durationTotal) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.serviceID, serviceID) ||
                other.serviceID == serviceID) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.start, start) || other.start == start));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, durationTotal, end, serviceID, serviceName, start);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectTimeVMImplCopyWith<_$ProjectTimeVMImpl> get copyWith =>
      __$$ProjectTimeVMImplCopyWithImpl<_$ProjectTimeVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectTimeVMImplToJson(
      this,
    );
  }
}

abstract class _ProjectTimeVM extends ProjectTimeVM {
  const factory _ProjectTimeVM(
      {final int? durationTotal,
      required final DateTime end,
      required final int serviceID,
      required final String serviceName,
      required final DateTime start}) = _$ProjectTimeVMImpl;
  const _ProjectTimeVM._() : super._();

  factory _ProjectTimeVM.fromJson(Map<String, dynamic> json) =
      _$ProjectTimeVMImpl.fromJson;

  @override
  int? get durationTotal;
  @override
  DateTime get end;
  @override
  int get serviceID;
  @override
  String get serviceName;
  @override
  DateTime get start;
  @override
  @JsonKey(ignore: true)
  _$$ProjectTimeVMImplCopyWith<_$ProjectTimeVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
