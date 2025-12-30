import 'package:http/http.dart' as http;

class GithubApi {
  static Future<void> fetch() async {
    var r = await http.get(
      Uri.parse('https://github.com/trending?since=monthly'),
    );
    var b = r.body;
    print(b);
  }
}
