


import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/core/utils/client_http.dart';
import 'package:ioatest/features/company/data/data_source/company_remote_data_source.dart';
import 'package:ioatest/features/company/data/entities/company_entity.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../json/json_resolver.dart';



class ClientHttpMock extends Mock implements ClientHttp{

  @override
  Future<http.Response> get(Uri? url, {Map<String, String>? headers}) =>
      super.noSuchMethod(Invocation.getter(#get),
           returnValue: Future.value(  http.Response('', 200)));
 
}

main() {
  late CompanyRemoteDataSource companyRemoteDataSource;
  late ClientHttpMock clientHttpMock;
  
  setUp((){
    clientHttpMock = ClientHttpMock();
    companyRemoteDataSource = CompanyRemoteDataSourceImp(clientHttp: clientHttpMock);
  });

  test('loadById must return a valid CompanyEntity',() async{
    //arrange
    final id = 49;

    final String path = '/enterprises';
    final String baseUrl = 'empresas.ioasys.com.br';
    final json = stringJsonFromFile('company_by_id.json');

    when(clientHttpMock.get(Uri.https(baseUrl, '$path/$id'))).thenAnswer((_) async => 
    http.Response(json, 200));
    //act
    final result = await companyRemoteDataSource.loadById(id);

    //assert
    expect(result.id, 49);
    expect(result.enterpriseName, 'Lifebit');
    expect(result.photo, '/uploads/enterprise/photo/49/240.jpeg');
    expect(result.description, 'Lifebit is building a cloud-based cognitive system that can reason about DNA data in the same way as humans. This offers researchers and R&D professionals, with limited-to-no computational and data analysis training, and their corresponding organisations (ie. pharmaceutical companies), a highly scalable, modular and reproducible system that automates the analysis processes, learns from the data and provides actionable insights.');
    expect(result.city, 'London');
    expect(result.country, 'UK');
    expect(result.phone, null);
    expect(result.value, 0);
    expect(result.sharePrice, 5000);
    expect(result.enterpriseType, EnterpriseTypeEntity(id: 5, enterpriseTypeName: 'Biotechnology'));
  });



  test('loadByName must return a valid CompanyEntity',() async{
    //arrange
    final name = 'Lifebit';
 
    final json = stringJsonFromFile('company_by_name.json');

    when(clientHttpMock.get(Uri.https('', ''))).thenAnswer((_) async => 
    http.Response(json, 200));
    //act
    final result = await companyRemoteDataSource.loadByName(name);

    //assert
    expect(result.first.id, 49);
    expect(result.first.enterpriseName, 'Lifebit');
    expect(result.first.photo, '/uploads/enterprise/photo/49/240.jpeg');
    expect(result.first.description, 'Lifebit is building a cloud-based cognitive system that can reason about DNA data in the same way as humans. This offers researchers and R&D professionals, with limited-to-no computational and data analysis training, and their corresponding organisations (ie. pharmaceutical companies), a highly scalable, modular and reproducible system that automates the analysis processes, learns from the data and provides actionable insights.');
    expect(result.first.city, 'London');
    expect(result.first.country, 'UK');
    expect(result.first.phone, null);
    expect(result.first.value, 0);
    expect(result.first.sharePrice, 5000);
    expect(result.first.enterpriseType, EnterpriseTypeEntity(id: 5, enterpriseTypeName: 'Biotechnology'));
  });
}
