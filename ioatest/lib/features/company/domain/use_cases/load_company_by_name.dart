import 'package:dartz/dartz.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:ioatest/core/errors/errors.dart';

///Use case of load company by name
abstract class LoadCompanyByName {
  ///The caller, use [filterName] to filter a company
  Future<Either<Error, List<Company>>> call({required String filterName});
}

///Default imp of [LoadCompanyByName]
class LoadCompanyByNameImp implements LoadCompanyByName {
  ///Constructor of [LoadCompanyByNameImp]
  LoadCompanyByNameImp({required this.companyRepository});

  ///the repository of company
  final CompanyRepository companyRepository;

  ///Will return a list of company filtered by name like [filterName].
  @override
  Future<Either<Error, List<Company>>> call({required String filterName}) =>
      companyRepository.loadByName(filterName);
}
