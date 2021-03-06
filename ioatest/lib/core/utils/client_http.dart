import 'package:http/http.dart' as http;
import 'package:ioatest/core/session/session_holder.dart';

///Implementation of [http.Client] to set default headers.
class ClientHttp extends http.BaseClient implements http.Client {
  final http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final defaultHeaders = _getDefaultHeaders();
    if (defaultHeaders != null) {
      request.headers.addAll(defaultHeaders);
    }
    return _httpClient.send(request);
  }

  Map<String, String>? _getDefaultHeaders() {
    final session = SessionHolder();
    final client = session.client;
    final uid = session.uid;
    final acessToken = session.accessToken;

    if (client == null || uid == null || acessToken == null) {
      return null;
    }

    return <String, String>{
      'client': client,
      'uid': uid,
      'access-token': acessToken
    };
  }
}
