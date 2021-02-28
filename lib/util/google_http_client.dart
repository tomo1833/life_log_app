import 'package:http/http.dart';
import 'package:http/io_client.dart' show IOClient;
import 'package:http/src/io_streamed_response.dart';

/// HTTP client that authenticates Google in Stream format.
///
/// [IOClient]Inherits
class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));

}