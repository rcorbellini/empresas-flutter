import 'package:dartz/dartz.dart';
import 'package:ioatest/features/company/domain/models/company.dart';

abstract class CompanyRepository {
  Future<Either<Error, Company>> loadById(int id);

  Future<Either<Error, List<Company>>> loadByName(String name);
}
