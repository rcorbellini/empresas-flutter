import 'package:ioatest/features/company/domain/models/company.dart';

abstract class CompanyRemoteDataSource {
  Future<Company> loadById(int id);

  Future<List<Company>> loadByName(String name);
}
