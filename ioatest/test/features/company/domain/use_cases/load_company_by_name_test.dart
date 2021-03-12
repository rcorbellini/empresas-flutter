

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/features/company/domain/models/company.dart'; 
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_name.dart';
import 'package:mockito/mockito.dart';


class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  late LoadCompanyByName loadCompanyByName;
  late MockCompanyRepository mockRepository;

  setUp(() {
    mockRepository = MockCompanyRepository();
    loadCompanyByName = LoadCompanyByName(companyRepository: mockRepository);
  });

  test('should use repository.loadByName to get company by name',
      () async {
    //->arrange

    final String name = 'Comp Test';

    final Company model = Company(
      id: 1,
      city: 'Canoas',
      country: 'Brasil',
      description: 'Comp desc Test',
      enterpriseName: name,
      ownShare: 20,
      sharePrice: 300,
      value: 4000,
      shares: 50000,
      emailEnterprise: 'r@gmail.com',
      facebook: '/test-facebook',
      linkedin: '/test-linkedin',
      twitter: '/test-twitter',
      phone: '5199999999',
      photo: '',    
      enterpriseType: EnterpriseType(
        id: 6,
        enterpriseTypeName: 'Ent type Name'
      )
        );

    
    when(mockRepository.loadByName(name))
        .thenAnswer((_) async => Right([model]));

    //->act
    final result = await loadCompanyByName.call(filterName: name );

    //->assert
    expect(result, contains(Right(model)) );
    verify(mockRepository.loadByName(name)); 
  });

}