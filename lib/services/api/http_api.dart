import 'package:http/http.dart' as http;

import 'api.dart';

class HttpApi implements Api {
  static const endpoint = 'myapi.com';

  var client = new http.Client();

  @override
  Future<bool> likePost(int postId) async {
    Uri url = Uri.https(endpoint, '/likePost/$postId');
    http.Response response = await client.post(url);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
