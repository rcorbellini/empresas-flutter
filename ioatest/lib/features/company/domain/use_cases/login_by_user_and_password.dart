import 'package:dartz/dartz.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/features/company/domain/models/user.dart';
import 'package:ioatest/features/company/domain/repositories/user_repository.dart';

abstract class LoginByUserAndPassword {
  Future<Either<Error, User>> call(
      {required String user, required String password});
}

class LoginByUserAndPasswordImp implements LoginByUserAndPassword {
  final UserRepository userRepository;

  LoginByUserAndPasswordImp({required this.userRepository});

  @override
  Future<Either<Error, User>> call(
          {required String user, required String password}) =>
      userRepository.login(user: user, password: password);
}
