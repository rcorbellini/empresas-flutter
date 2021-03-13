import 'dart:convert';
import 'dart:io';

Map<String, dynamic> jsonFromFile(String fileName) {
  return jsonDecode(stringJsonFromFile(fileName));
}

String stringJsonFromFile(String fileName) {
  return File('test/json/$fileName').readAsStringSync();
}
