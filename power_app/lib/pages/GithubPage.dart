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
      case 'Java':
        return Colors.purple;
      case 'Go':
        return Colors.red;
      case 'C++':
        return Colors.indigo;
      case 'JavaScript':
        return Colors.orange;
      default:
        return Colors.pink;
    }
  }

  // final Map<String, List<String>> fruits = {
  //   'Apple': ['Red Apple', 'Green Apple'],
  //   'Banana': ['Yellow Banana', 'Brown Banana'],
  //   'Lemon': ['Yellow Lemon', 'Green Lemon'],
  //   'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],
  // };
  String? selectedValue;

  List<SpokeLanguage> _filteredFruits(String searchQuery) {
    return [];
    // for (final entry in fruits.entries) {
    //   final filteredValues = entry.value
    //       .where((value) => _filterName(value, searchQuery))
    //       .toList();
    //   if (filteredValues.isNotEmpty) {
    //     yield MapEntry(entry.key, filteredValues);
    //   } else if (_filterName(entry.key, searchQuery)) {
    //     yield entry;
    //   }
    // }
  }

  // bool _filterName(String name, String searchQuery) {
  //   return name.toLowerCase().contains(searchQuery);
  // }

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
          return Column(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Container(),
                    Row(
                      children: [
                        Select<String>(
                          popup: SelectPopup.builder(
                            builder: (context, searchQuery) async {
                              List<SpokeLanguage> list =
                                  await GithubApi.spokenLanguageList();
                              if (searchQuery != null) {
                                list = list.where((e) {
                                  return e.spokenLanguage.contains(searchQuery);
                                }).toList();
                              }
                              return SelectItemBuilder(
                                childCount: list.isEmpty ? 0 : null,
                                builder: (context, index) {
                                  return SelectGroup(
                                    children: [
                                      for (final value in list)
                                        SelectItemButton(
                                          value: value,
                                          child: Text(value.spokenLanguage),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          ).call,
                          itemBuilder: (context, item) {
                            return Text(item);
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          constraints: const BoxConstraints(minWidth: 200),
                          value: selectedValue,
                          placeholder: const Text('Any'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    var element = list[i] as TrendItem;
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            offset: const Offset(0, 10),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      margin: .symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        spacing: 4,
                        children: [
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Flexible(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: .start,
                                  spacing: 5,
                                  children: [
                                    Row(
                                      spacing: 3,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.appStore,
                                          size: 20,
                                        ),
                                        Text(
                                          '${element.author}/${element.projectName}',
                                          style: .new(color: Colors.blue),
                                        ).h4,
                                      ],
                                    ),
                                    Text(
                                      element.desc,
                                      style: .new(overflow: .ellipsis),
                                      maxLines: 2,
                                    ),
                                    Row(
                                      spacing: 8,
                                      children: [
                                        Row(
                                          spacing: 3,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    _calcColorForProgramingLan(
                                                      element.programLanguage,
                                                    ),
                                                borderRadius: .all(
                                                  .circular(8),
                                                ),
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
                                          spacing: 3,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.star,
                                              size: 16,
                                            ),
                                            Text(
                                              '${element.stars}',
                                              style: .new(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          spacing: 3,
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
                                          spacing: 3,
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
                                                    image: NetworkImage(
                                                      e.avatar,
                                                    ),
                                                  ),
                                                  borderRadius: .all(
                                                    .circular(10),
                                                  ),
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
                                      style: .new(
                                        fontSize: 12,
                                        color: Colors.gray,
                                      ),
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
                ),
              ),
            ],
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
