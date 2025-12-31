import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  static Future<List<TrendItem?>> fetch() async {
    var r = await http.get(
      Uri.parse('https://github.com/trending?since=monthly'),
    );
    var b = r.body;
    var document = HtmlParser(b);
    var list = document.parse().querySelectorAll('.Box-row');
    var itemList = list
        .map((e) {
          var a = e.querySelector('.lh-condensed > a');
          // print(a?.attributes['href']);
          var str = a?.attributes['href']?.substring(1).split('/');
          var lan = e.querySelectorAll('div.color-fg-muted > span > span');
          // print(lan[1].text);
          var atag = e.querySelectorAll('div.color-fg-muted > a');
          var spanTag = e.querySelectorAll(
            'div.color-fg-muted > span.d-inline-block',
          );
          if (str != null &&
              str.length == 2 &&
              lan.length == 2 &&
              atag.length == 2 &&
              spanTag.length == 3) {
            var buildBy = spanTag[1].children.map((a) {
              var username = a.attributes['href']!.substring(1);
              var avatar = a.firstChild!.attributes['src']!;
              return BuildBy(author: username, avatar: avatar);
            }).toList();
            print(buildBy);
            return TrendItem(
              author: str[0],
              projectName: str[1],
              programLanguage: lan[1].text,
              stars: atag[0].text.trim(),
              forks: atag[1].text.trim(),
              buildBy: buildBy,
            );
          }
          return null;
        })
        .where((e) => e != null)
        .toList();
    print(itemList);
    return itemList;
  }
}

class TrendItem {
  String author;
  String projectName;
  String programLanguage;
  String stars;
  String forks;
  List<BuildBy> buildBy;

  TrendItem({
    required this.author,
    required this.projectName,
    required this.programLanguage,
    required this.stars,
    required this.forks,
    required this.buildBy,
  });

  @override
  String toString() {
    return '{author:$author, projectName:$projectName,programLanguage:$programLanguage,stars:$stars,forks:$forks,buildBy:$buildBy}';
  }
}

class BuildBy {
  String author;
  String avatar;

  BuildBy({required this.author, required this.avatar});

  @override
  String toString() {
    return '{author:$author,avatar:$avatar}';
  }
}

void main() {
  GithubApi.fetch();
}
