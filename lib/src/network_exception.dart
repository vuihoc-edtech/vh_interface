
// move from vuihoc-app-auth to common
import 'package:vh_interface/src/result.dart';

import 'model/enums.dart';

abstract class NetworkException<T> extends Result<T> implements Exception {
  // code > 0: http exception
  // code < 0: app exception
  final int code;
  final String message;
  final UIType uiType;
  final dynamic data;

  // description for dev
  final String? description;

  NetworkException({
    this.code = ExceptionCode.unknownException,
    this.message = '',
    this.description,
    this.data,
    this.uiType = UIType.SNACK,
  });

  factory NetworkException.parse({int? code, String? message, data}) {
    switch (code) {
      case ExceptionCode.socketException:
        return BaseException(
          message: 'Lỗi kết nối. Vui lòng kiểm tra lại kết nối mạng',
          code: ExceptionCode.socketException,
          description: 'Kiểm tra lại kết nối wifi/3g của bạn',
          data: data,
        );
      default:
        return BaseException(
          code: code ??= ExceptionCode.unknownException,
          message: message ?? 'Đã có lỗi xảy ra',
          data: data,
        );
    }
  }

  @override
  String toString() =>
      'NetworkException {code: $code message: $message - $description}';
}

class BaseException<T> extends NetworkException<T> {
  BaseException({
    super.code,
    super.message,
    super.description,
    super.data,
    super.uiType,
  });
}

class UnknownException extends NetworkException {
  UnknownException({super.description})
      : super(code: -1, message: 'Đã có lỗi xảy ra');
}




/// Define custom exception code
class ExceptionCode {
  static const unknownException = -1;

  static const socketException = -2;

  // HTTP code
  static const requestTimeout = 408;
  static const tooManyRequest = 429;
  static const internalServerError = 500;
  static const serviceUnavailable = 503;
  static const gatewayTimeout = 504;
}