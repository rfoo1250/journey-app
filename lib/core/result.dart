/// Domain-layer result type (docs/PLAN.md §6): features return
/// `Result<T>` instead of throwing across boundaries.
sealed class Result<T> {
  const new();

  const factory ok(T value) = Ok<T>;
  const factory err(AppError error) = Err<T>;

  bool get isOk => this is Ok<T>;

  T? get valueOrNull => switch (this) {
    Ok<T>(:final value) => value,
    Err<T>() => null,
  };

  AppError? get errorOrNull => switch (this) {
    Ok<T>() => null,
    Err<T>(:final error) => error,
  };
}

final class Ok<T> extends Result<T> {
  const new(this.value);
  final T value;

  @override
  String toString() => 'Ok($value)';
}

final class Err<T> extends Result<T> {
  const new(this.error);
  final AppError error;

  @override
  String toString() => 'Err($error)';
}

/// Errors surfaced to the user via ErrorPresenter (docs/PLAN.md §6).
sealed class AppError {
  const new(this.message, {this.cause});

  /// Human-readable, safe to show in a SnackBar.
  final String message;
  final Object? cause;

  @override
  String toString() => 'AppError: $message';
}

/// Server unreachable, timed out, or returned a non-2xx status.
final class NetworkError extends AppError {
  const new(super.message, {super.cause, this.statusCode});
  final int? statusCode;
}

/// Server answered but the payload was not what we expected.
final class ParseError extends AppError {
  const new(super.message, {super.cause});
}

/// Input did not meet a precondition (e.g. too few points to match).
final class InvalidInputError extends AppError {
  const new(super.message);
}

/// Local persistence failed.
final class StorageError extends AppError {
  const new(super.message, {super.cause});
}
