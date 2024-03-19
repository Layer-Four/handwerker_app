// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectCustomer _$ProjectCustomerFromJson(Map<String, dynamic> json) {
  return _ProjectCustomer.fromJson(json);
}

/// @nodoc
mixin _$ProjectCustomer {
  String get customer => throw _privateConstructorUsedError;
  List<ProjectOverview> get projects => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCustomerCopyWith<ProjectCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCustomerCopyWith<$Res> {
  factory $ProjectCustomerCopyWith(
          ProjectCustomer value, $Res Function(ProjectCustomer) then) =
      _$ProjectCustomerCopyWithImpl<$Res, ProjectCustomer>;
  @useResult
  $Res call({String customer, List<ProjectOverview> projects});
}

/// @nodoc
class _$ProjectCustomerCopyWithImpl<$Res, $Val extends ProjectCustomer>
    implements $ProjectCustomerCopyWith<$Res> {
  _$ProjectCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = null,
    Object? projects = null,
  }) {
    return _then(_value.copyWith(
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String,
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<ProjectOverview>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectCustomerImplCopyWith<$Res>
    implements $ProjectCustomerCopyWith<$Res> {
  factory _$$ProjectCustomerImplCopyWith(_$ProjectCustomerImpl value,
          $Res Function(_$ProjectCustomerImpl) then) =
      __$$ProjectCustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String customer, List<ProjectOverview> projects});
}

/// @nodoc
class __$$ProjectCustomerImplCopyWithImpl<$Res>
    extends _$ProjectCustomerCopyWithImpl<$Res, _$ProjectCustomerImpl>
    implements _$$ProjectCustomerImplCopyWith<$Res> {
  __$$ProjectCustomerImplCopyWithImpl(
      _$ProjectCustomerImpl _value, $Res Function(_$ProjectCustomerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customer = null,
    Object? projects = null,
  }) {
    return _then(_$ProjectCustomerImpl(
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String,
      projects: null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<ProjectOverview>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectCustomerImpl extends _ProjectCustomer {
  const _$ProjectCustomerImpl(
      {required this.customer, required final List<ProjectOverview> projects})
      : _projects = projects,
        super._();

  factory _$ProjectCustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectCustomerImplFromJson(json);

  @override
  final String customer;
  final List<ProjectOverview> _projects;
  @override
  List<ProjectOverview> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  String toString() {
    return 'ProjectCustomer(customer: $customer, projects: $projects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectCustomerImpl &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, customer, const DeepCollectionEquality().hash(_projects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectCustomerImplCopyWith<_$ProjectCustomerImpl> get copyWith =>
      __$$ProjectCustomerImplCopyWithImpl<_$ProjectCustomerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectCustomerImplToJson(
      this,
    );
  }
}

abstract class _ProjectCustomer extends ProjectCustomer {
  const factory _ProjectCustomer(
      {required final String customer,
      required final List<ProjectOverview> projects}) = _$ProjectCustomerImpl;
  const _ProjectCustomer._() : super._();

  factory _ProjectCustomer.fromJson(Map<String, dynamic> json) =
      _$ProjectCustomerImpl.fromJson;

  @override
  String get customer;
  @override
  List<ProjectOverview> get projects;
  @override
  @JsonKey(ignore: true)
  _$$ProjectCustomerImplCopyWith<_$ProjectCustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
