import 'package:http/http.dart' as http;

class ClientHttp extends http.BaseClient implements http.Client {
  final http.Client _httpClient = new http.Client();
  final Map<String, String> defaultHeaders;

  ClientHttp({required this.defaultHeaders});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }
}
