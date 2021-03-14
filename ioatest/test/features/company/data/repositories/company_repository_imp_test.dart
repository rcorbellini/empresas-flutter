import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/core/errors/exceptions.dart';
import 'package:ioatest/core/utils/network_status.dart';
import 'package:ioatest/features/company/data/data_source/company_cache_data_source.dart';
import 'package:ioatest/features/company/data/data_source/company_remote_data_source.dart';
import 'package:ioatest/features/company/data/entities/company_entity.dart';
import 'package:ioatest/features/company/data/repositories/company_repository_imp.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:mockito/mockito.dart';

late CompanyEntity model;

///Mockito workaround (by null-safe, readme of mockito, https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md)
class CompanyRemoteDataSourceMock extends Mock
    implements CompanyRemoteDataSource {
  @override
  Future<CompanyEntity> loadById(int id) =>
      super.noSuchMethod(Invocation.getter(#loadById),
          returnValue: Future.value(model));

  @override
  Future<List<CompanyEntity>> loadByName(String name) =>
      super.noSuchMethod(Invocation.getter(#loadByName),
          returnValue: Future.value(<CompanyEntity>[]));
}

class CompanyCacheDataSourceMock extends Mock
    implements CompanyCacheDataSource {
  @override
  Future<Company?> loadById(int id) =>
      super.noSuchMethod(Invocation.getter(#loadById),
          returnValue: Future.value(model));

  @override
  Future<void> cacheCompany(Company company) =>
      super.noSuchMethod(Invocation.getter(#cacheCompany),
          returnValueForMissingStub: Future.value(Void));
}

class NetworkStatusMock extends Mock implements NetworkStatus {
  @override
  Future<bool> isConnected() =>
      super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future.value(false));
}

void main() {
  late CompanyRemoteDataSourceMock remote;
  late CompanyCacheDataSourceMock cache;
  late CompanyRepository companyRepository;
  late NetworkStatusMock networkStatusMock;

  final name = 'Comp';
  final id = 1;

  setUp(() {
    remote = CompanyRemoteDataSourceMock();
    cache = CompanyCacheDataSourceMock();
    networkStatusMock = NetworkStatusMock();
    companyRepository = CompanyRepositoryImp(
        remote: remote, cache: cache, networkStatus: networkStatusMock);

    model = CompanyEntity(
        id: id,
        city: 'Canoas',
        country: 'Brasil',
        description: 'Comp Test',
        enterpriseName: name,
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
  });

  test('loadById should use cache, when are cached ', () async {
    //arrange
    when(cache.loadById(id)).thenAnswer((_) async => model);

    //act
    final result = await companyRepository.loadById(id) as Right;

    //assert
    verify(cache.loadById(id));
    verifyZeroInteractions(networkStatusMock);
    verifyZeroInteractions(remote);
    expect(result.value, model);
  });

  test('loadById should use remote, when no cached value ', () async {
    //arrange
    when(cache.loadById(id)).thenAnswer((_) async => null);
    when(networkStatusMock.isConnected()).thenAnswer((_) async => true);
    when(remote.loadById(id)).thenAnswer((_) async => model);

    //act
    final result = await companyRepository.loadById(id) as Right;

    //assert
    verify(remote.loadById(id));
    expect(result.value, model);
  });

  test('loadById should return erro when no cached value and no internet ',
      () async {
    //arrange
    when(networkStatusMock.isConnected()).thenAnswer((_) async => false);
    when(cache.loadById(id)).thenAnswer((_) async => null);

    //act
    final result = await companyRepository.loadById(id) as Left;

    //assert
    verifyZeroInteractions(remote);
    expect(result.value, isA<NoInternetError>());
  });

  test('loadByName should use remote ', () async {
    //arrange
    when(remote.loadByName(name)).thenAnswer((_) async => [model]);
    when(networkStatusMock.isConnected()).thenAnswer((_) async => true);

    //act
    final result = await companyRepository.loadByName(name) as Right;

    //assert
    verify(remote.loadByName(name));
    verifyZeroInteractions(cache);
    expect(result.value, equals([model]));
  });

  test('loadByName if no internet must return erro', () async {
    //arrange
    when(networkStatusMock.isConnected()).thenAnswer((_) async => false);

    //act
    final result = await companyRepository.loadByName(name) as Left;

    //assert
    verifyZeroInteractions(cache);
    verifyZeroInteractions(remote);
    expect(result.value, isA<NoInternetError>());
  });

  test('loadByName must return RemoteError, when remote throws Exception',
      () async {
    //arrange
    when(networkStatusMock.isConnected()).thenAnswer((_) async => true);
    when(remote.loadByName(name))
        .thenAnswer((_) async => throw RemoteException());

    //act
    final result = await companyRepository.loadByName(name) as Left;

    //assert
    verify(remote.loadByName(name));
    verifyZeroInteractions(cache);
    expect(result.value, isA<RemoteError>());
  });
}
