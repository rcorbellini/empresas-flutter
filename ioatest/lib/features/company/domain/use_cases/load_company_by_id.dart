import 'package:dartz/dartz.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';

abstract class LoadCompanyById {
  Future<Either<Error, Company>> call({required int filterId});
}

class LoadCompanyByIdImp implements LoadCompanyById {
  LoadCompanyByIdImp({required this.companyRepository});

  final CompanyRepository companyRepository;

  @override
  Future<Either<Error, Company>> call({required int filterId}) =>
      companyRepository.loadById(filterId);
}
