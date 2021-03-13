import 'package:ioatest/features/company/domain/models/company.dart';

abstract class CompanyCacheDataSource {
  Future<Company?> loadById(int id);

  Future<void> cacheCompany(Company company);
}

class CompanyCacheDataSourceImp extends CompanyCacheDataSource {
  final Map<int, Company> memory = {};

  @override
  Future<void> cacheCompany(Company company) async {
    memory.putIfAbsent(company.id, () => company);
  }

  @override
  Future<Company?> loadById(int id) async {
    return memory[id];
  }
}
