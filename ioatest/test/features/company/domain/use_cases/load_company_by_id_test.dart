import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_id.dart';
import 'package:mockito/mockito.dart';
import 'package:ioatest/core/errors/errors.dart';

late Company model;

///Mockito workaround (by null-safe, readme of mockito, https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md)
class MockCompanyRepository extends Mock implements CompanyRepository {
  @override
  Future<Either<Error, Company>> loadById(int id) =>
      super.noSuchMethod(Invocation.getter(#loadById),
          returnValue: Future.value(Right<Error, Company>(model)));
}

void main() {
  late LoadCompanyById loadCompanyById;
  late MockCompanyRepository mockRepository;

  setUp(() {
    mockRepository = MockCompanyRepository();
    loadCompanyById = LoadCompanyByIdImp(companyRepository: mockRepository);
  });

  test('should use repository.loadById to get company by id', () async {
    //->arrange
    model = Company(
        id: 1,
        city: 'Canoas',
        country: 'Brasil',
        description: 'Comp Test',
        enterpriseName: 'Comp',
        ownShare: 20,
        sharePrice: 300,
        value: 4000,
        shares: 50000,
        ownEnterprise: false,
        emailEnterprise: 'r@gmail.com',
        facebook: '/test-facebook',
        linkedin: '/test-linkedin',
        twitter: '/test-twitter',
        phone: '5199999999',
        photo: '',
        enterpriseType:
            EnterpriseType(id: 6, enterpriseTypeName: 'Ent type Name'));
    final int id = 1;
    when(mockRepository.loadById(id))
        .thenAnswer((_) async => Right<Error, Company>(model));

    //->act
    final result = await loadCompanyById.call(filterId: id) as Right;

    //->assert
    expect(result.value, model);
    verify(mockRepository.loadById(id));
  });
}
