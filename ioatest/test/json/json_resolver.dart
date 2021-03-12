import 'dart:convert';
import 'dart:io';

Map<String, dynamic> resolveJsonFromFile(String fileName){
  return jsonDecode(File('test/json/$fileName').readAsStringSync());
}