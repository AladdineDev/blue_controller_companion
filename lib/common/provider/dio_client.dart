import 'package:blue_controller_companion/env/env.dart';
import 'package:blue_controller_companion/features/login/data/repository/jwt_repository.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
FutureOr<Dio> dioClient(
  DioClientRef ref,
) async {
  final jwt = await ref.watch(jwtRepositoryProvider).readJwt();
  final headers = {
    if (jwt != null) "Authorization": "Bearer $jwt",
  };
  final baseOptions = BaseOptions(
    baseUrl: Env.apiBaseUrl,
    headers: headers,
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 5),
  );
  final dio = Dio(baseOptions);
  dio.interceptors.add(PrettyDioLogger());
  return dio;
}
