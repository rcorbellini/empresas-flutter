import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/core/errors/exceptions.dart';
import 'package:ioatest/core/utils/network_status.dart';
import 'package:ioatest/features/company/data/data_source/user_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:ioatest/features/company/domain/models/user.dart';
import 'package:ioatest/features/company/domain/repositories/user_repository.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDataSource remote;
  final NetworkStatus networkStatus;

  UserRepositoryImp({required this.remote, required this.networkStatus});

  @override
  Future<Either<Error, User>> login(
      {required String user, required String password}) async {
    final isConnected = await networkStatus.isConnected();
    if (!isConnected) {
      return Left(NoInternetError());
    }

    try {
      final remoteCompany =
          await remote.login(username: user, password: password);
      return Right(remoteCompany);
    } on RemoteException catch (e) {
      if (e is UnauthorizedException) {
        return Left(UnauthorizedError());
      }

      return Left(RemoteError());
    }
  }
}
