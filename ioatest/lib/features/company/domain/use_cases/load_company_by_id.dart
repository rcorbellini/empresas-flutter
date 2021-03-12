import 'package:dartz/dartz.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';

abstract class LoadCompanyById {
  Future<Either<Error, Company>> call({required int filterId});
}

class LoadCompanyByIdImp implements LoadCompanyById {
  CompanyRepository companyRepository;

  LoadCompanyByIdImp({required this.companyRepository});

  @override
  Future<Either<Error, Company>> call({required int filterId}) =>
      companyRepository.loadById(filterId);
}
