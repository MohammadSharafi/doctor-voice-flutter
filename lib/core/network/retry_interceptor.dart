import 'dart:io';

import 'package:dio/dio.dart';
import 'dio_connectivity_request_retrier.dart';
import 'package:aimedic/core/network/refresh_service.dart';

import 'network_service.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError( DioError err, ErrorInterceptorHandler handler,) async {
    try {
      if(err.response?.statusCode==403 || err.response?.statusCode==401)
      {
        Future.delayed(Duration(seconds: 5)).then((value) =>{
          RefreshService(NetworkService.instance.dio).refreshToken()
        });
      }
    if (_shouldRetry(err)) {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
    }
    } catch (e) {
      return e;
    }
    super.onError(err, handler);

  }

  bool _shouldRetry(DioError err) {
    print(err);

    return err.type == DioErrorType.other && err.error != null && err.error is SocketException;
  }


}


