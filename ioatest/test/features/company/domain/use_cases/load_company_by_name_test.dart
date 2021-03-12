import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_name.dart';
import 'package:mockito/mockito.dart';

///Mockito workaround (by null-safe, readme of mockito, https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md)
class MockCompanyRepository extends Mock implements CompanyRepository {
  @override
  Future<Either<Error, List<Company>>> loadByName(String name) =>
      super.noSuchMethod(Invocation.getter(#loadByName),
          returnValue: Future.value(Right<Error, List<Company>>([])));
}

void main() {
  late LoadCompanyByName loadCompanyByName;
  late MockCompanyRepository mockRepository;

  setUp(() {
    mockRepository = MockCompanyRepository();
    loadCompanyByName = LoadCompanyByNameImp(companyRepository: mockRepository);
  });

  test('should use repository.loadByName to get company by name', () async {
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
        enterpriseType:
            EnterpriseType(id: 6, enterpriseTypeName: 'Ent type Name'));


    when(mockRepository.loadByName(name))
        .thenAnswer((_) async => Right<Error, List<Company>>([model]));

    //->act
    final result = await loadCompanyByName.call(filterName: name) as Right;
    //->assert1
    expect(result.value, equals([model]));
    verify(mockRepository.loadByName(name));
  });
}
