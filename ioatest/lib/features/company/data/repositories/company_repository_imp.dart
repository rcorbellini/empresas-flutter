import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/core/errors/exceptions.dart';
import 'package:ioatest/core/utils/network_status.dart';
import 'package:ioatest/features/company/data/data_source/company_cache_data_source.dart';
import 'package:ioatest/features/company/data/data_source/company_remote_data_source.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:dartz/dartz.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';

///The implementation of [CompanyRepository], with all rules about store.
class CompanyRepositoryImp extends CompanyRepository {
  ///the constructor
  CompanyRepositoryImp(
      {required this.cache, required this.remote, required this.networkStatus});

  final CompanyCacheDataSource cache;
  final CompanyRemoteDataSource remote;
  final NetworkStatus networkStatus;

  @override
  Future<Either<Error, Company>> loadById(int id) async {
    final cachedCompany = await cache.loadById(id);
    if (cachedCompany != null) {
      return Right(cachedCompany);
    }

    final isConnected = await networkStatus.isConnected();
    if (!isConnected) {
      return Left(NoInternetError());
    }

    try {
      final remoteCompany = await remote.loadById(id);
      await cache.cacheCompany(remoteCompany);
      return Right(remoteCompany);
    } on RemoteException {
      return Left(RemoteError());
    }
  }

  @override
  Future<Either<Error, List<Company>>> loadByName(String name) async {
    final isConnected = await networkStatus.isConnected();
    if (!isConnected) {
      return Left(NoInternetError());
    }

    try {
      final remoteCompany = await remote.loadByName(name);
      return Right(remoteCompany);
    } on RemoteException {
      return Left(RemoteError());
    }
  }
}
