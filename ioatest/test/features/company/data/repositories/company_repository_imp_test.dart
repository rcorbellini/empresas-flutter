import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/features/company/data/data_source/company_cache_data_source.dart';
import 'package:ioatest/features/company/data/data_source/company_remote_data_source.dart';
import 'package:ioatest/features/company/data/repositories/company_repository_imp.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:mockito/mockito.dart';

late Company model;

///Mockito workaround (by null-safe, readme of mockito, https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md)
class CompanyRemoteDataSourceMock extends Mock
    implements CompanyRemoteDataSource {
  @override
  Future<Company> loadById(int id) =>
      super.noSuchMethod(Invocation.getter(#loadById),
          returnValue: Future.value(model));

  @override
  Future<List<Company>> loadByName(String name) =>
      super.noSuchMethod(Invocation.getter(#loadByName),
          returnValue: Future.value([]));
}

class CompanyCacheDataSourceMock extends Mock
    implements CompanyCacheDataSource {
  Future<Company?> loadById(int id) =>
      super.noSuchMethod(Invocation.getter(#loadById),
          returnValue: Future.value(null));

  void cacheCompany(Company company);
}

main() {
  late CompanyRemoteDataSourceMock remote;
  late CompanyCacheDataSourceMock cache;
  late CompanyRepository companyRepository;


  final name = 'Comp';
  final id = 1;

  setUp(() {
    remote = CompanyRemoteDataSourceMock();
    cache = CompanyCacheDataSourceMock();
    companyRepository = CompanyRepositoryImp(remote: remote, cache: cache);


    model = Company(
        id: id,
        city: 'Canoas',
        country: 'Brasil',
        description: 'Comp Test',
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
  });

  test('loadById should use cache, when are cached ', () async {
    //arrange
    when(cache.loadById(id)).thenAnswer((_) async => model);

    //act
    final result = await companyRepository.loadById(id);

    //assert
    verify(cache.loadById(id));
    verifyZeroInteractions(remote);
    expect(result, model);
  });


  test('loadById should use remote, when no cached value ', () async {
    //arrange
    when(cache.loadById(id)).thenAnswer((_) async => null);
    when(remote.loadById(id)).thenAnswer((_) async => model);

    //act
    final result = await companyRepository.loadById(id);

    //assert
    verify(remote.loadById(id));
    expect(result, model);
  });


  test('loadByName should use remote ', () async {
    //arrange 
    when(remote.loadByName(name)).thenAnswer((_) async => [model]);

    //act
    final result = await companyRepository.loadById(id);

    //assert
    verify(remote.loadByName(name));
    verifyZeroInteractions(cache);
    expect(result, [model]);
  });
}
