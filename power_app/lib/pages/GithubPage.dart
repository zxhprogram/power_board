import 'package:flutter/material.dart'
    hide CircularProgressIndicator, Colors, Divider;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_app/api/GithubApi.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class GithubPage extends StatefulWidget {
  @override
  State<GithubPage> createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {
  late Stream<List<TrendItem?>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = Stream.fromFuture(GithubApi.fetch());
  }

  Color _calcColorForProgramingLan(String lan) {
    switch (lan) {
      case 'Rust':
        return Colors.amber;
      case 'Python':
        return Colors.blue;
      case 'TypeScript':
        return Colors.blue;
      case 'JavaScript':
        return Colors.orange;
      default:
        return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder(
        stream: _stream,
        initialData: [],
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return Center(child: Text('there is an error from server'));
          }
          if (asyncSnapshot.connectionState == .waiting) {
            return Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
          var list = asyncSnapshot.data;
          if (list == null) {
            return Center(child: Text('there is no data from server'));
          }
          return ListView.builder(
            itemBuilder: (c, i) {
              var element = list[i] as TrendItem;
              return Container(
                margin: .all(5),
                child: Column(
                  spacing: 4,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: .start,
                            spacing: 5,
                            children: [
                              Text(
                                '${element.author}/${element.projectName}',
                                style: .new(color: Colors.blue),
                              ).h4,
                              Text(
                                element.desc,
                                style: .new(overflow: .ellipsis),
                                maxLines: 2,
                              ),
                              Row(
                                spacing: 8,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: _calcColorForProgramingLan(
                                            element.programLanguage,
                                          ),
                                          borderRadius: .all(.circular(8)),
                                        ),
                                      ).sized(width: 16, height: 16),
                                      Text(
                                        element.programLanguage,
                                        style: .new(
                                          color: Colors.teal,
                                          fontSize: 12,
                                        ),
                                      ).normal,
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.star, size: 16),
                                      Text(
                                        '${element.stars}',
                                        style: .new(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.codeBranch,
                                        size: 16,
                                      ),
                                      Text(
                                        '${element.forks}',
                                        style: .new(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    spacing: 2,
                                    children: [
                                      Text(
                                        'Built By',
                                        style: .new(fontSize: 12),
                                      ),
                                      ...element.buildBy.map((e) {
                                        return Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(e.avatar),
                                            ),
                                            borderRadius: .all(.circular(10)),
                                            border: .all(
                                              color: Colors.gray,
                                              width: 0.5,
                                            ),
                                          ),
                                          clipBehavior: .hardEdge,
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Text(''),
                              Text(
                                '${element.starsInPeriod} stars today',
                                style: .new(fontSize: 12, color: Colors.gray),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.purple, thickness: 1),
                  ],
                ),
              );
            },
            itemCount: list.length,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    print('github page dispose');
    super.dispose();
  }
}
