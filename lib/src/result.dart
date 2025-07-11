import 'network_exception.dart';

class Result<T> with SealedResult<T> {
  bool get isSuccessful => this is Success<T>;

  Result<T> transform({
    required T Function(T)? success,
    NetworkException<T> Function(NetworkException<T>)? error,
  }) {
    if (this is Success<T> && success != null) {
      (this as Success<T>).data = success.call((this as Success<T>).data);
    }
    if (this is NetworkException<T> && error != null) {
      // return error.call(this as NetworkException<T>);
    }
    return this;
  }
}

class Success<T> extends Result<T> {
  Success(this.data);

  T data;
}

mixin SealedResult<T> {
  R? when<R>({
    R Function(T)? success,
    R Function(NetworkException<dynamic>)? error,
  }) {
    if (this is Success<T>) {
      return success?.call((this as Success<T>).data);
    }
    if (this is NetworkException<T>) {
      return error?.call(this as NetworkException);
    }
    throw Exception(
      'If you got here, probably you forgot to regenerate the classes? '
      'Try running flutter packages pub run build_runner build',
    );
  }
}
