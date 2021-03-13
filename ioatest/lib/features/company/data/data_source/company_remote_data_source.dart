import 'dart:convert';

import 'package:ioatest/core/errors/exceptions.dart';
import 'package:ioatest/core/utils/client_http.dart';
import 'package:ioatest/features/company/data/entities/company_entity.dart';

abstract class CompanyRemoteDataSource {
  Future<CompanyEntity> loadById(int id);

  Future<List<CompanyEntity>> loadByName(String name);
}

class CompanyRemoteDataSourceImp extends CompanyRemoteDataSource {
  final ClientHttp clientHttp;

  final String path = '/enterprises';
  final String baseUrl = 'empresas.ioasys.com.br';

  CompanyRemoteDataSourceImp({required this.clientHttp});

  @override
  Future<CompanyEntity> loadById(int id) async {
    final url = Uri.https(baseUrl, '$path/$id');
    final response = await clientHttp
        .get(url, headers: {'content-type': 'application/json'});

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['enterprise'];

      return CompanyEntity.fromJson(result);
    } else {
      throw RemoteException();
    }
  }

  @override
  Future<List<CompanyEntity>> loadByName(String name) async {
    final url = Uri.https(baseUrl, path, {'name': name});
    final response = await clientHttp
        .get(url, headers: {'content-type': 'application/json'});

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['enterprises'] as Iterable;

      return result.map((item) => CompanyEntity.fromJson(item)).toList();
    } else {
      throw RemoteException();
    }
  }
}
