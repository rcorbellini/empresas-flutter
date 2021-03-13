import 'dart:convert';

import 'package:http/http.dart';
import 'package:ioatest/core/errors/exceptions.dart';
import 'package:ioatest/core/session/session_holder.dart';
import 'package:ioatest/features/company/data/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<UserEntity> login(
      {required String username, required String password});
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  final Client clientHttp;

  final String path = '/api/v1/users/auth/sign_in';
  final String baseUrl = 'empresas.ioasys.com.br';

  UserRemoteDataSourceImp({required this.clientHttp});

  @override
  Future<UserEntity> login(
      {required String username, required String password}) async {
    final url = Uri.https(baseUrl, '$path');
    final response = await clientHttp.post(url,        
        body: {'email': username, 'password': password});

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['investor'];

      final session = SessionHolder();
      session.uid = response.headers['uid'];
      session.client = response.headers['client'];
      session.accessToken = response.headers['access-token'];

      return UserEntity.fromJson(result);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw RemoteException();
    }
  }
}
