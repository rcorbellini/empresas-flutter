import 'package:dartz/dartz.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/features/company/domain/models/user.dart';

abstract class UserRepository {
  Future<Either<Error, User>> login(
      {required String user, required String password});
}
