// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectOverview _$ProjectOverviewFromJson(Map<String, dynamic> json) {
  return _ProjectOverView.fromJson(json);
}

/// @nodoc
mixin _$ProjectOverview {
  int get customerID => throw _privateConstructorUsedError;
  String? get customerName => throw _privateConstructorUsedError;
  bool get hasDocumentations => throw _privateConstructorUsedError;
  List<ConsumeableVM> get materialViewModels =>
      throw _privateConstructorUsedError; // @Default([]) List materialViewModels,
  DateTime get projectCreated => throw _privateConstructorUsedError;
  int get projectID =>
      throw _privateConstructorUsedError; // @Default([]) List projectMaterials,
  String? get projectName => throw _privateConstructorUsedError;
  List<ProjectTimeVM> get timeViewModels => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectOverviewCopyWith<ProjectOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectOverviewCopyWith<$Res> {
  factory $ProjectOverviewCopyWith(
          ProjectOverview value, $Res Function(ProjectOverview) then) =
      _$ProjectOverviewCopyWithImpl<$Res, ProjectOverview>;
  @useResult
  $Res call(
      {int customerID,
      String? customerName,
      bool hasDocumentations,
      List<ConsumeableVM> materialViewModels,
      DateTime projectCreated,
      int projectID,
      String? projectName,
      List<ProjectTimeVM> timeViewModels});
}

/// @nodoc
class _$ProjectOverviewCopyWithImpl<$Res, $Val extends ProjectOverview>
    implements $ProjectOverviewCopyWith<$Res> {
  _$ProjectOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerID = null,
    Object? customerName = freezed,
    Object? hasDocumentations = null,
    Object? materialViewModels = null,
    Object? projectCreated = null,
    Object? projectID = null,
    Object? projectName = freezed,
    Object? timeViewModels = null,
  }) {
    return _then(_value.copyWith(
      customerID: null == customerID
          ? _value.customerID
          : customerID // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDocumentations: null == hasDocumentations
          ? _value.hasDocumentations
          : hasDocumentations // ignore: cast_nullable_to_non_nullable
              as bool,
      materialViewModels: null == materialViewModels
          ? _value.materialViewModels
          : materialViewModels // ignore: cast_nullable_to_non_nullable
              as List<ConsumeableVM>,
      projectCreated: null == projectCreated
          ? _value.projectCreated
          : projectCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int,
      projectName: freezed == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String?,
      timeViewModels: null == timeViewModels
          ? _value.timeViewModels
          : timeViewModels // ignore: cast_nullable_to_non_nullable
              as List<ProjectTimeVM>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectOverViewImplCopyWith<$Res>
    implements $ProjectOverviewCopyWith<$Res> {
  factory _$$ProjectOverViewImplCopyWith(_$ProjectOverViewImpl value,
          $Res Function(_$ProjectOverViewImpl) then) =
      __$$ProjectOverViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int customerID,
      String? customerName,
      bool hasDocumentations,
      List<ConsumeableVM> materialViewModels,
      DateTime projectCreated,
      int projectID,
      String? projectName,
      List<ProjectTimeVM> timeViewModels});
}

/// @nodoc
class __$$ProjectOverViewImplCopyWithImpl<$Res>
    extends _$ProjectOverviewCopyWithImpl<$Res, _$ProjectOverViewImpl>
    implements _$$ProjectOverViewImplCopyWith<$Res> {
  __$$ProjectOverViewImplCopyWithImpl(
      _$ProjectOverViewImpl _value, $Res Function(_$ProjectOverViewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerID = null,
    Object? customerName = freezed,
    Object? hasDocumentations = null,
    Object? materialViewModels = null,
    Object? projectCreated = null,
    Object? projectID = null,
    Object? projectName = freezed,
    Object? timeViewModels = null,
  }) {
    return _then(_$ProjectOverViewImpl(
      customerID: null == customerID
          ? _value.customerID
          : customerID // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDocumentations: null == hasDocumentations
          ? _value.hasDocumentations
          : hasDocumentations // ignore: cast_nullable_to_non_nullable
              as bool,
      materialViewModels: null == materialViewModels
          ? _value._materialViewModels
          : materialViewModels // ignore: cast_nullable_to_non_nullable
              as List<ConsumeableVM>,
      projectCreated: null == projectCreated
          ? _value.projectCreated
          : projectCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      projectID: null == projectID
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as int,
      projectName: freezed == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String?,
      timeViewModels: null == timeViewModels
          ? _value._timeViewModels
          : timeViewModels // ignore: cast_nullable_to_non_nullable
              as List<ProjectTimeVM>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectOverViewImpl extends _ProjectOverView {
  const _$ProjectOverViewImpl(
      {required this.customerID,
      this.customerName,
      this.hasDocumentations = false,
      final List<ConsumeableVM> materialViewModels = const <ConsumeableVM>[],
      required this.projectCreated,
      required this.projectID,
      this.projectName,
      final List<ProjectTimeVM> timeViewModels = const <ProjectTimeVM>[]})
      : _materialViewModels = materialViewModels,
        _timeViewModels = timeViewModels,
        super._();

  factory _$ProjectOverViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectOverViewImplFromJson(json);

  @override
  final int customerID;
  @override
  final String? customerName;
  @override
  @JsonKey()
  final bool hasDocumentations;
  final List<ConsumeableVM> _materialViewModels;
  @override
  @JsonKey()
  List<ConsumeableVM> get materialViewModels {
    if (_materialViewModels is EqualUnmodifiableListView)
      return _materialViewModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_materialViewModels);
  }

// @Default([]) List materialViewModels,
  @override
  final DateTime projectCreated;
  @override
  final int projectID;
// @Default([]) List projectMaterials,
  @override
  final String? projectName;
  final List<ProjectTimeVM> _timeViewModels;
  @override
  @JsonKey()
  List<ProjectTimeVM> get timeViewModels {
    if (_timeViewModels is EqualUnmodifiableListView) return _timeViewModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeViewModels);
  }

  @override
  String toString() {
    return 'ProjectOverview(customerID: $customerID, customerName: $customerName, hasDocumentations: $hasDocumentations, materialViewModels: $materialViewModels, projectCreated: $projectCreated, projectID: $projectID, projectName: $projectName, timeViewModels: $timeViewModels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectOverViewImpl &&
            (identical(other.customerID, customerID) ||
                other.customerID == customerID) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.hasDocumentations, hasDocumentations) ||
                other.hasDocumentations == hasDocumentations) &&
            const DeepCollectionEquality()
                .equals(other._materialViewModels, _materialViewModels) &&
            (identical(other.projectCreated, projectCreated) ||
                other.projectCreated == projectCreated) &&
            (identical(other.projectID, projectID) ||
                other.projectID == projectID) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            const DeepCollectionEquality()
                .equals(other._timeViewModels, _timeViewModels));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      customerID,
      customerName,
      hasDocumentations,
      const DeepCollectionEquality().hash(_materialViewModels),
      projectCreated,
      projectID,
      projectName,
      const DeepCollectionEquality().hash(_timeViewModels));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectOverViewImplCopyWith<_$ProjectOverViewImpl> get copyWith =>
      __$$ProjectOverViewImplCopyWithImpl<_$ProjectOverViewImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectOverViewImplToJson(
      this,
    );
  }
}

abstract class _ProjectOverView extends ProjectOverview {
  const factory _ProjectOverView(
      {required final int customerID,
      final String? customerName,
      final bool hasDocumentations,
      final List<ConsumeableVM> materialViewModels,
      required final DateTime projectCreated,
      required final int projectID,
      final String? projectName,
      final List<ProjectTimeVM> timeViewModels}) = _$ProjectOverViewImpl;
  const _ProjectOverView._() : super._();

  factory _ProjectOverView.fromJson(Map<String, dynamic> json) =
      _$ProjectOverViewImpl.fromJson;

  @override
  int get customerID;
  @override
  String? get customerName;
  @override
  bool get hasDocumentations;
  @override
  List<ConsumeableVM> get materialViewModels;
  @override // @Default([]) List materialViewModels,
  DateTime get projectCreated;
  @override
  int get projectID;
  @override // @Default([]) List projectMaterials,
  String? get projectName;
  @override
  List<ProjectTimeVM> get timeViewModels;
  @override
  @JsonKey(ignore: true)
  _$$ProjectOverViewImplCopyWith<_$ProjectOverViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
