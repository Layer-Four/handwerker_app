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
  String get title => throw _privateConstructorUsedError;
  DateTime get dateOfTermination => throw _privateConstructorUsedError;
  List<dynamic> get projectMaterials => throw _privateConstructorUsedError;
  List<UserProjectDay> get userProjectDays =>
      throw _privateConstructorUsedError;

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
      {String title,
      DateTime dateOfTermination,
      List<dynamic> projectMaterials,
      List<UserProjectDay> userProjectDays});
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
    Object? title = null,
    Object? dateOfTermination = null,
    Object? projectMaterials = null,
    Object? userProjectDays = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfTermination: null == dateOfTermination
          ? _value.dateOfTermination
          : dateOfTermination // ignore: cast_nullable_to_non_nullable
              as DateTime,
      projectMaterials: null == projectMaterials
          ? _value.projectMaterials
          : projectMaterials // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      userProjectDays: null == userProjectDays
          ? _value.userProjectDays
          : userProjectDays // ignore: cast_nullable_to_non_nullable
              as List<UserProjectDay>,
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
      {String title,
      DateTime dateOfTermination,
      List<dynamic> projectMaterials,
      List<UserProjectDay> userProjectDays});
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
    Object? title = null,
    Object? dateOfTermination = null,
    Object? projectMaterials = null,
    Object? userProjectDays = null,
  }) {
    return _then(_$ProjectOverViewImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfTermination: null == dateOfTermination
          ? _value.dateOfTermination
          : dateOfTermination // ignore: cast_nullable_to_non_nullable
              as DateTime,
      projectMaterials: null == projectMaterials
          ? _value._projectMaterials
          : projectMaterials // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      userProjectDays: null == userProjectDays
          ? _value._userProjectDays
          : userProjectDays // ignore: cast_nullable_to_non_nullable
              as List<UserProjectDay>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectOverViewImpl extends _ProjectOverView {
  const _$ProjectOverViewImpl(
      {required this.title,
      required this.dateOfTermination,
      final List<dynamic> projectMaterials = const [],
      final List<UserProjectDay> userProjectDays = const <UserProjectDay>[]})
      : _projectMaterials = projectMaterials,
        _userProjectDays = userProjectDays,
        super._();

  factory _$ProjectOverViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectOverViewImplFromJson(json);

  @override
  final String title;
  @override
  final DateTime dateOfTermination;
  final List<dynamic> _projectMaterials;
  @override
  @JsonKey()
  List<dynamic> get projectMaterials {
    if (_projectMaterials is EqualUnmodifiableListView)
      return _projectMaterials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectMaterials);
  }

  final List<UserProjectDay> _userProjectDays;
  @override
  @JsonKey()
  List<UserProjectDay> get userProjectDays {
    if (_userProjectDays is EqualUnmodifiableListView) return _userProjectDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userProjectDays);
  }

  @override
  String toString() {
    return 'ProjectOverview(title: $title, dateOfTermination: $dateOfTermination, projectMaterials: $projectMaterials, userProjectDays: $userProjectDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectOverViewImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.dateOfTermination, dateOfTermination) ||
                other.dateOfTermination == dateOfTermination) &&
            const DeepCollectionEquality()
                .equals(other._projectMaterials, _projectMaterials) &&
            const DeepCollectionEquality()
                .equals(other._userProjectDays, _userProjectDays));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      dateOfTermination,
      const DeepCollectionEquality().hash(_projectMaterials),
      const DeepCollectionEquality().hash(_userProjectDays));

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
      {required final String title,
      required final DateTime dateOfTermination,
      final List<dynamic> projectMaterials,
      final List<UserProjectDay> userProjectDays}) = _$ProjectOverViewImpl;
  const _ProjectOverView._() : super._();

  factory _ProjectOverView.fromJson(Map<String, dynamic> json) =
      _$ProjectOverViewImpl.fromJson;

  @override
  String get title;
  @override
  DateTime get dateOfTermination;
  @override
  List<dynamic> get projectMaterials;
  @override
  List<UserProjectDay> get userProjectDays;
  @override
  @JsonKey(ignore: true)
  _$$ProjectOverViewImplCopyWith<_$ProjectOverViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
