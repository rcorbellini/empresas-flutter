

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/features/company/domain/models/company.dart'; 
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_id.dart';
import 'package:mockito/mockito.dart';
 


class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  late LoadCompanyById loadCompanyById;
  late MockCompanyRepository mockRepository;

  setUp(() {
    mockRepository = MockCompanyRepository();
    loadCompanyById = LoadCompanyById(companyRepository: mockRepository);
  });

  test('should use repository.loadById to get company by id',
      () async {
    //->arrange

    final int id = 1;

    final Company model = Company(
      id: id,
      city: 'Canoas',
      country: 'Brasil',
      description: 'Comp Test',
      enterpriseName: 'Comp',
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

    
    when(mockRepository.loadById(id))
        .thenAnswer((_) async => Right([model]));

    //->act
    final result = await loadCompanyById.call(filterId: id);

    //->assert
    expect(result, contains(Right(model)) );
    verify(mockRepository.loadById(id)); 
  });

}