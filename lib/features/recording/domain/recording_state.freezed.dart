// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordingState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RecordingState()';
}


}

/// @nodoc
class $RecordingStateCopyWith<$Res>  {
$RecordingStateCopyWith(RecordingState _, $Res Function(RecordingState) __);
}


/// Adds pattern-matching-related methods to [RecordingState].
extension RecordingStatePatterns on RecordingState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecordingIdle value)?  idle,TResult Function( RecordingRequestingPermission value)?  requestingPermission,TResult Function( RecordingActive value)?  recording,TResult Function( RecordingPaused value)?  paused,TResult Function( RecordingProcessing value)?  processing,TResult Function( RecordingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecordingIdle() when idle != null:
return idle(_that);case RecordingRequestingPermission() when requestingPermission != null:
return requestingPermission(_that);case RecordingActive() when recording != null:
return recording(_that);case RecordingPaused() when paused != null:
return paused(_that);case RecordingProcessing() when processing != null:
return processing(_that);case RecordingError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecordingIdle value)  idle,required TResult Function( RecordingRequestingPermission value)  requestingPermission,required TResult Function( RecordingActive value)  recording,required TResult Function( RecordingPaused value)  paused,required TResult Function( RecordingProcessing value)  processing,required TResult Function( RecordingError value)  error,}){
final _that = this;
switch (_that) {
case RecordingIdle():
return idle(_that);case RecordingRequestingPermission():
return requestingPermission(_that);case RecordingActive():
return recording(_that);case RecordingPaused():
return paused(_that);case RecordingProcessing():
return processing(_that);case RecordingError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecordingIdle value)?  idle,TResult? Function( RecordingRequestingPermission value)?  requestingPermission,TResult? Function( RecordingActive value)?  recording,TResult? Function( RecordingPaused value)?  paused,TResult? Function( RecordingProcessing value)?  processing,TResult? Function( RecordingError value)?  error,}){
final _that = this;
switch (_that) {
case RecordingIdle() when idle != null:
return idle(_that);case RecordingRequestingPermission() when requestingPermission != null:
return requestingPermission(_that);case RecordingActive() when recording != null:
return recording(_that);case RecordingPaused() when paused != null:
return paused(_that);case RecordingProcessing() when processing != null:
return processing(_that);case RecordingError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  requestingPermission,TResult Function( DateTime startedAt,  int fixCount,  Position? lastFix)?  recording,TResult Function( DateTime startedAt,  int fixCount,  Position? lastFix)?  paused,TResult Function( DateTime startedAt)?  processing,TResult Function( RecordingErrorKind kind,  String? message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecordingIdle() when idle != null:
return idle();case RecordingRequestingPermission() when requestingPermission != null:
return requestingPermission();case RecordingActive() when recording != null:
return recording(_that.startedAt,_that.fixCount,_that.lastFix);case RecordingPaused() when paused != null:
return paused(_that.startedAt,_that.fixCount,_that.lastFix);case RecordingProcessing() when processing != null:
return processing(_that.startedAt);case RecordingError() when error != null:
return error(_that.kind,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  requestingPermission,required TResult Function( DateTime startedAt,  int fixCount,  Position? lastFix)  recording,required TResult Function( DateTime startedAt,  int fixCount,  Position? lastFix)  paused,required TResult Function( DateTime startedAt)  processing,required TResult Function( RecordingErrorKind kind,  String? message)  error,}) {final _that = this;
switch (_that) {
case RecordingIdle():
return idle();case RecordingRequestingPermission():
return requestingPermission();case RecordingActive():
return recording(_that.startedAt,_that.fixCount,_that.lastFix);case RecordingPaused():
return paused(_that.startedAt,_that.fixCount,_that.lastFix);case RecordingProcessing():
return processing(_that.startedAt);case RecordingError():
return error(_that.kind,_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  requestingPermission,TResult? Function( DateTime startedAt,  int fixCount,  Position? lastFix)?  recording,TResult? Function( DateTime startedAt,  int fixCount,  Position? lastFix)?  paused,TResult? Function( DateTime startedAt)?  processing,TResult? Function( RecordingErrorKind kind,  String? message)?  error,}) {final _that = this;
switch (_that) {
case RecordingIdle() when idle != null:
return idle();case RecordingRequestingPermission() when requestingPermission != null:
return requestingPermission();case RecordingActive() when recording != null:
return recording(_that.startedAt,_that.fixCount,_that.lastFix);case RecordingPaused() when paused != null:
return paused(_that.startedAt,_that.fixCount,_that.lastFix);case RecordingProcessing() when processing != null:
return processing(_that.startedAt);case RecordingError() when error != null:
return error(_that.kind,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RecordingIdle implements RecordingState {
  const RecordingIdle();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RecordingState.idle()';
}


}




/// @nodoc


class RecordingRequestingPermission implements RecordingState {
  const RecordingRequestingPermission();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingRequestingPermission);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RecordingState.requestingPermission()';
}


}




/// @nodoc


class RecordingActive implements RecordingState {
  const RecordingActive({required this.startedAt, this.fixCount = 0, this.lastFix});
  

 final  DateTime startedAt;
@JsonKey() final  int fixCount;
 final  Position? lastFix;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingActiveCopyWith<RecordingActive> get copyWith => _$RecordingActiveCopyWithImpl<RecordingActive>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingActive&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.fixCount, fixCount) || other.fixCount == fixCount)&&(identical(other.lastFix, lastFix) || other.lastFix == lastFix));
}


@override
int get hashCode {
    return Object.hash(runtimeType,startedAt,fixCount,lastFix);
}

@override
String toString() {
    return 'RecordingState.recording(startedAt: $startedAt, fixCount: $fixCount, lastFix: $lastFix)';
}


}

/// @nodoc
abstract mixin class $RecordingActiveCopyWith<$Res> implements $RecordingStateCopyWith<$Res> {
  factory $RecordingActiveCopyWith(RecordingActive value, $Res Function(RecordingActive) _then) = _$RecordingActiveCopyWithImpl;
@useResult
$Res call({
 DateTime startedAt, int fixCount, Position? lastFix
});




}
/// @nodoc
class _$RecordingActiveCopyWithImpl<$Res>
    implements $RecordingActiveCopyWith<$Res> {
  _$RecordingActiveCopyWithImpl(this._self, this._then);

  final RecordingActive _self;
  final $Res Function(RecordingActive) _then;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startedAt = null,Object? fixCount = null,Object? lastFix = freezed,}) {
  return _then(RecordingActive(
startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,fixCount: null == fixCount ? _self.fixCount : fixCount // ignore: cast_nullable_to_non_nullable
as int,lastFix: freezed == lastFix ? _self.lastFix : lastFix // ignore: cast_nullable_to_non_nullable
as Position?,
  ));
}


}

/// @nodoc


class RecordingPaused implements RecordingState {
  const RecordingPaused({required this.startedAt, this.fixCount = 0, this.lastFix});
  

 final  DateTime startedAt;
@JsonKey() final  int fixCount;
 final  Position? lastFix;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingPausedCopyWith<RecordingPaused> get copyWith => _$RecordingPausedCopyWithImpl<RecordingPaused>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingPaused&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.fixCount, fixCount) || other.fixCount == fixCount)&&(identical(other.lastFix, lastFix) || other.lastFix == lastFix));
}


@override
int get hashCode {
    return Object.hash(runtimeType,startedAt,fixCount,lastFix);
}

@override
String toString() {
    return 'RecordingState.paused(startedAt: $startedAt, fixCount: $fixCount, lastFix: $lastFix)';
}


}

/// @nodoc
abstract mixin class $RecordingPausedCopyWith<$Res> implements $RecordingStateCopyWith<$Res> {
  factory $RecordingPausedCopyWith(RecordingPaused value, $Res Function(RecordingPaused) _then) = _$RecordingPausedCopyWithImpl;
@useResult
$Res call({
 DateTime startedAt, int fixCount, Position? lastFix
});




}
/// @nodoc
class _$RecordingPausedCopyWithImpl<$Res>
    implements $RecordingPausedCopyWith<$Res> {
  _$RecordingPausedCopyWithImpl(this._self, this._then);

  final RecordingPaused _self;
  final $Res Function(RecordingPaused) _then;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startedAt = null,Object? fixCount = null,Object? lastFix = freezed,}) {
  return _then(RecordingPaused(
startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,fixCount: null == fixCount ? _self.fixCount : fixCount // ignore: cast_nullable_to_non_nullable
as int,lastFix: freezed == lastFix ? _self.lastFix : lastFix // ignore: cast_nullable_to_non_nullable
as Position?,
  ));
}


}

/// @nodoc


class RecordingProcessing implements RecordingState {
  const RecordingProcessing({required this.startedAt});
  

 final  DateTime startedAt;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingProcessingCopyWith<RecordingProcessing> get copyWith => _$RecordingProcessingCopyWithImpl<RecordingProcessing>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingProcessing&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,startedAt);
}

@override
String toString() {
    return 'RecordingState.processing(startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $RecordingProcessingCopyWith<$Res> implements $RecordingStateCopyWith<$Res> {
  factory $RecordingProcessingCopyWith(RecordingProcessing value, $Res Function(RecordingProcessing) _then) = _$RecordingProcessingCopyWithImpl;
@useResult
$Res call({
 DateTime startedAt
});




}
/// @nodoc
class _$RecordingProcessingCopyWithImpl<$Res>
    implements $RecordingProcessingCopyWith<$Res> {
  _$RecordingProcessingCopyWithImpl(this._self, this._then);

  final RecordingProcessing _self;
  final $Res Function(RecordingProcessing) _then;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startedAt = null,}) {
  return _then(RecordingProcessing(
startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class RecordingError implements RecordingState {
  const RecordingError({required this.kind, this.message});
  

 final  RecordingErrorKind kind;
 final  String? message;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingErrorCopyWith<RecordingError> get copyWith => _$RecordingErrorCopyWithImpl<RecordingError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingError&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,message);
}

@override
String toString() {
    return 'RecordingState.error(kind: $kind, message: $message)';
}


}

/// @nodoc
abstract mixin class $RecordingErrorCopyWith<$Res> implements $RecordingStateCopyWith<$Res> {
  factory $RecordingErrorCopyWith(RecordingError value, $Res Function(RecordingError) _then) = _$RecordingErrorCopyWithImpl;
@useResult
$Res call({
 RecordingErrorKind kind, String? message
});




}
/// @nodoc
class _$RecordingErrorCopyWithImpl<$Res>
    implements $RecordingErrorCopyWith<$Res> {
  _$RecordingErrorCopyWithImpl(this._self, this._then);

  final RecordingError _self;
  final $Res Function(RecordingError) _then;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? message = freezed,}) {
  return _then(RecordingError(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RecordingErrorKind,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
