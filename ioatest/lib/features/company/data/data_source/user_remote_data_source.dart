import 'dart:convert';

import 'package:http/http.dart';
import 'package:ioatest/core/errors/exceptions.dart';
import 'package:ioatest/core/session/session_holder.dart';
import 'package:ioatest/features/company/data/entities/user_entity.dart';

///Abstraction of Remote acess of user
abstract class UserRemoteDataSource {
  Future<UserEntity> login(
      {required String username, required String password});
}

///The default implementation of remote datasource of user.
class UserRemoteDataSourceImp extends UserRemoteDataSource {
  ///the constructor
  UserRemoteDataSourceImp({required this.clientHttp});

  ///the client of Http
  final Client clientHttp;

  final String _path = '/api/v1/users/auth/sign_in';
  final String _baseUrl = 'empresas.ioasys.com.br';

  @override
  Future<UserEntity> login(
      {required String username, required String password}) async {
    final url = Uri.https(_path, '$_baseUrl');
    final response = await clientHttp
        .post(url, body: {'email': username, 'password': password});

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['investor'];

      SessionHolder()
        ..uid = response.headers['uid']
        ..client = response.headers['client']
        ..accessToken = response.headers['access-token'];

      return UserEntity.fromJson(result);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw RemoteException();
    }
  }
}
