import 'package:flutter_test/flutter_test.dart';
import 'package:ioatest/features/company/data/entities/company_entity.dart';
import '../../../../json/json_resolver.dart';

main() {
  setUp(() {});

  test('Json must create a valid entity', () {
    //arrage
    final json = jsonFromFile('company.json');

    //act
    final result = CompanyEntity.fromJson(json);

    //assert
    expect(result.id, 49);
    expect(result.enterpriseName, 'Lifebit');
    expect(result.photo, '/uploads/enterprise/photo/49/240.jpeg');
    expect(result.description,
        'Lifebit is building a cloud-based cognitive system that can reason about DNA data in the same way as humans. This offers researchers and R&D professionals, with limited-to-no computational and data analysis training, and their corresponding organisations (ie. pharmaceutical companies), a highly scalable, modular and reproducible system that automates the analysis processes, learns from the data and provides actionable insights.');
    expect(result.city, 'London');
    expect(result.country, 'UK');
    expect(result.phone, null);
    expect(result.value, 0);
    expect(result.sharePrice, 5000);
    expect(result.enterpriseType,
        EnterpriseTypeEntity(id: 5, enterpriseTypeName: 'Biotechnology'));
  });
}
