// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectMaterialVM _$ProjectMaterialVMFromJson(Map<String, dynamic> json) {
  return _ProjectMaterialVM.fromJson(json);
}

/// @nodoc
mixin _$ProjectMaterialVM {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectMaterialVMCopyWith<$Res> {
  factory $ProjectMaterialVMCopyWith(
          ProjectMaterialVM value, $Res Function(ProjectMaterialVM) then) =
      _$ProjectMaterialVMCopyWithImpl<$Res, ProjectMaterialVM>;
}

/// @nodoc
class _$ProjectMaterialVMCopyWithImpl<$Res, $Val extends ProjectMaterialVM>
    implements $ProjectMaterialVMCopyWith<$Res> {
  _$ProjectMaterialVMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ProjectMaterialVMImplCopyWith<$Res> {
  factory _$$ProjectMaterialVMImplCopyWith(_$ProjectMaterialVMImpl value,
          $Res Function(_$ProjectMaterialVMImpl) then) =
      __$$ProjectMaterialVMImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProjectMaterialVMImplCopyWithImpl<$Res>
    extends _$ProjectMaterialVMCopyWithImpl<$Res, _$ProjectMaterialVMImpl>
    implements _$$ProjectMaterialVMImplCopyWith<$Res> {
  __$$ProjectMaterialVMImplCopyWithImpl(_$ProjectMaterialVMImpl _value,
      $Res Function(_$ProjectMaterialVMImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ProjectMaterialVMImpl extends _ProjectMaterialVM {
  const _$ProjectMaterialVMImpl() : super._();

  factory _$ProjectMaterialVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectMaterialVMImplFromJson(json);

  @override
  String toString() {
    return 'ProjectMaterialVM()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProjectMaterialVMImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectMaterialVMImplToJson(
      this,
    );
  }
}

abstract class _ProjectMaterialVM extends ProjectMaterialVM {
  const factory _ProjectMaterialVM() = _$ProjectMaterialVMImpl;
  const _ProjectMaterialVM._() : super._();

  factory _ProjectMaterialVM.fromJson(Map<String, dynamic> json) =
      _$ProjectMaterialVMImpl.fromJson;
}
