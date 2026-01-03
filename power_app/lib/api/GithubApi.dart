import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  static List<ProgramingLanguage> _programingLanguages = [];
  static List<SpokeLanguage> _spokenLanguages = [];

  static Future<List<TrendItem?>> fetch({String? programingLan}) async {
    var r = await http.get(
      programingLan == null
          ? Uri.parse('https://github.com/trending?since=daily')
          : Uri.parse('https://github.com/trending/$programingLan?since=daily'),
    );
    print('statusCode = ${r.statusCode}');
    var b = r.body;
    var document = HtmlParser(b);
    var list = document.parse().querySelectorAll('.Box-row');
    var itemList = list
        .map((e) {
          var a = e.querySelector('.lh-condensed > a');
          var str = a?.attributes['href']?.substring(1).split('/');
          var lan = e.querySelectorAll('div.color-fg-muted > span > span');
          var atag = e.querySelectorAll('div.color-fg-muted > a');
          var spanTag = e.querySelectorAll(
            'div.color-fg-muted > span.d-inline-block',
          );
          var desc = e.querySelector('p')?.text.trim() ?? '';
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
            var starsInPeriod = spanTag[2].text.trim();
            print(buildBy);
            return TrendItem(
              author: str[0],
              projectName: str[1],
              programLanguage: lan[1].text,
              stars: matchNumberInString(atag[0].text.trim()),
              forks: matchNumberInString(atag[1].text.trim()),
              buildBy: buildBy,
              starsInPeriod: matchNumberInString(starsInPeriod),
              desc: desc,
            );
          }
          return null;
        })
        .where((e) => e != null)
        .toList();
    print(itemList);
    return itemList;
  }

  static Future<List<SpokeLanguage>> spokenLanguageList() async {
    if (_spokenLanguages.isNotEmpty) {
      return _spokenLanguages;
    }
    var r = await http.get(
      Uri.parse('https://github.com/trending?since=daily'),
    );
    print('statusCode = ${r.statusCode}');
    var b = r.body;
    var document = HtmlParser(b);
    var dataMenuButtonTextList = document.parse().querySelectorAll(
      '.Box-header > .d-sm-flex > .position-relative > details > details-menu > .select-menu-list > div > a',
    );
    print(dataMenuButtonTextList.length);
    _spokenLanguages = dataMenuButtonTextList.map((e) {
      var lan = e.children[0].text.trim();
      var url = e.attributes['href']!;
      var pMap = Uri.parse(url).queryParameters;
      var shortFormat = pMap['spoken_language_code'] ?? '';
      return SpokeLanguage(spokenLanguage: lan, shortFormat: shortFormat);
    }).toList();
    return _spokenLanguages;
  }

  static Future<List<ProgramingLanguage>> programingLanguageList() async {
    if (_programingLanguages.isNotEmpty) {
      return _programingLanguages;
    }
    var r = await http.get(
      Uri.parse('https://github.com/trending?since=daily'),
    );
    print('statusCode = ${r.statusCode}');
    var b = r.body;
    var document = HtmlParser(b);
    var dataMenuButtonTextList = document.parse().querySelectorAll(
      '.Box-header > .d-sm-flex > .mb-3 > details > details-menu > .select-menu-list > div > a',
    );
    print(dataMenuButtonTextList.length);
    _programingLanguages = dataMenuButtonTextList.map((e) {
      var lan = e.text.trim();
      print(lan);
      return ProgramingLanguage(showName: lan, queryName: lan.toLowerCase());
    }).toList();
    return _programingLanguages;
  }
}

int matchNumberInString(String s) {
  var r = RegExp(r'\d+');
  var rr = r.allMatches(s);
  print(rr.length);
  StringBuffer buffer = StringBuffer();
  for (var value in rr) {
    var subs = s.substring(value.start, value.end);
    buffer.write(subs);
  }
  print(buffer.toString());
  return int.parse(buffer.toString());
}

class TrendItem {
  String author;
  String projectName;
  String programLanguage;
  int stars;
  int forks;
  List<BuildBy> buildBy;
  int starsInPeriod;
  String desc;

  TrendItem({
    required this.author,
    required this.projectName,
    required this.programLanguage,
    required this.stars,
    required this.forks,
    required this.buildBy,
    required this.starsInPeriod,
    required this.desc,
  });

  @override
  String toString() {
    return '{author:$author, projectName:$projectName,programLanguage:$programLanguage,stars:$stars,forks:$forks,buildBy:$buildBy,starsInPeriod:$starsInPeriod}';
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

class SpokeLanguage {
  String spokenLanguage;
  String shortFormat;

  SpokeLanguage({required this.spokenLanguage, required this.shortFormat});
}

class ProgramingLanguage {
  String showName;
  String queryName;

  ProgramingLanguage({required this.showName, required this.queryName});
}

void main() {
  // var map = Uri.parse(
  //   'https://github.com/trending?spken_language=zh&a=b',
  // ).queryParameters;
  // print(map);
  // GithubApi.fetch();
  GithubApi.programingLanguageList();
  // var r = RegExp(r'\d+');
  // var s = "14,840 stars this month";
  // var rr = r.allMatches(s);
  // print(rr.length);
  // StringBuffer buffer = StringBuffer();
  // for (var value in rr) {
  //   var subs = s.substring(value.start, value.end);
  //   buffer.write(subs);
  // }
  // print(buffer.toString());
}
