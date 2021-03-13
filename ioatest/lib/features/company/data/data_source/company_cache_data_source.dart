import 'package:ioatest/features/company/domain/models/company.dart';

abstract class CompanyCacheDataSource {
  Future<Company?> loadById(int id);

  Future<void> cacheCompany(Company company);
}
