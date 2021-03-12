import 'package:dartz/dartz.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';

abstract class LoadCompanyByName {
  Future<Either<Error, List<Company>>> call({required String filterName});
}

class LoadCompanyByNameImp implements LoadCompanyByName {
  CompanyRepository companyRepository;

  LoadCompanyByNameImp({required this.companyRepository});

  ///Will return a list of company filtered by name like [filterName].
  @override
  Future<Either<Error, List<Company>>> call({required String filterName}) =>
      companyRepository.loadByName(filterName);
}
