// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectListVM _$ProjectListVMFromJson(Map<String, dynamic> json) {
  return _ProjectListVM.fromJson(json);
}

/// @nodoc
mixin _$ProjectListVM {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectListVMCopyWith<ProjectListVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectListVMCopyWith<$Res> {
  factory $ProjectListVMCopyWith(
          ProjectListVM value, $Res Function(ProjectListVM) then) =
      _$ProjectListVMCopyWithImpl<$Res, ProjectListVM>;
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class _$ProjectListVMCopyWithImpl<$Res, $Val extends ProjectListVM>
    implements $ProjectListVMCopyWith<$Res> {
  _$ProjectListVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectListVMImplCopyWith<$Res>
    implements $ProjectListVMCopyWith<$Res> {
  factory _$$ProjectListVMImplCopyWith(
          _$ProjectListVMImpl value, $Res Function(_$ProjectListVMImpl) then) =
      __$$ProjectListVMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title});
}

/// @nodoc
class __$$ProjectListVMImplCopyWithImpl<$Res>
    extends _$ProjectListVMCopyWithImpl<$Res, _$ProjectListVMImpl>
    implements _$$ProjectListVMImplCopyWith<$Res> {
  __$$ProjectListVMImplCopyWithImpl(
      _$ProjectListVMImpl _value, $Res Function(_$ProjectListVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$ProjectListVMImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectListVMImpl implements _ProjectListVM {
  const _$ProjectListVMImpl({required this.id, required this.title});

  factory _$ProjectListVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectListVMImplFromJson(json);

  @override
  final int id;
  @override
  final String title;

  @override
  String toString() {
    return 'ProjectListVM(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectListVMImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectListVMImplCopyWith<_$ProjectListVMImpl> get copyWith =>
      __$$ProjectListVMImplCopyWithImpl<_$ProjectListVMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectListVMImplToJson(
      this,
    );
  }
}

abstract class _ProjectListVM implements ProjectListVM {
  const factory _ProjectListVM(
      {required final int id,
      required final String title}) = _$ProjectListVMImpl;

  factory _ProjectListVM.fromJson(Map<String, dynamic> json) =
      _$ProjectListVMImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$ProjectListVMImplCopyWith<_$ProjectListVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
