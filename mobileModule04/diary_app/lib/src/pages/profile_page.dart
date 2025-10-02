import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/diary_operations.dart';
import '../utils/diary_operations.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late Future<List<Map<String, dynamic>>> _fetchDiaryEntries;
  List<Map<String, dynamic>>? _diaryEntries;

  @override
  void initState() {
    super.initState();
    _fetchDiaryEntries = database.getDiaryEntries();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - 84;
    final width = MediaQuery.of(context).size.width - 32;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Your last diary entries",
            style: TextStyle(
              fontFamily: 'Cursive',
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color.fromARGB(255, 59, 42, 35),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed:
                () => ref
                    .read(database.authenticationProvider.notifier)
                    .signOut(context),
          ),
        ],
      ),
      body:
          height <= 0 || width <= 0
              ? null
              : ListView(
                children: [
                  SizedBox(
                    height: 5 * height / 6,
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _fetchDiaryEntries,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${snapshot.error}',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          _diaryEntries = snapshot.data;
                          if (_diaryEntries!.isEmpty) {
                            return Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "No diary entries found.",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            );
                          }

                          return ListView(
                            padding: const EdgeInsets.all(16.0),
                            children: [
                              for (int i = 0; i < _diaryEntries!.length; i++)
                                _diaryEntryCard(i, width: width / 5),
                            ],
                          );
                        }
                        return Column();
                      },
                    ),
                  ),
                  SizedBox(
                    height: height / 6,
                    child: Center(
                      child: SizedBox(
                        height: height / 15,
                        width: width / 2,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool success = await addDiaryEntry(context);
                            if (success) {
                              setState(() {
                                _fetchDiaryEntries = database.getDiaryEntries();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              187,
                              65,
                              21,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(height / 60),
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'New diary entry',
                              style: TextStyle(
                                fontSize: height / 40,
                                fontFamily: 'Cursive',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }

  Card _diaryEntryCard(int index, {required double width}) {
    final DateTime date =
        DateTime.parse(_diaryEntries![index]["date"]).toLocal();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: icons[_diaryEntries![index]["icon_index"]]["color"].withAlpha(125),
      child: InkWell(
        onTap: () async {
          bool success = await viewDiaryEntry(context, _diaryEntries![index]);
          if (success) {
            setState(() {
              _fetchDiaryEntries = database.getDiaryEntries();
            });
          }
        },
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          height: 70.0,
          child: Center(
            child: ListTile(
              leading: SizedBox(
                width: width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    children: [
                      Text(
                        "${date.day}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Cursive',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        months[date.month - 1],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Cursive',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${date.year}",
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'Cursive',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(width: width / 2),
                    Icon(
                      icons[_diaryEntries![index]["icon_index"]]["icon"],
                      color: Colors.white,
                      size: 30.0,
                    ),
                    Text(
                      "  |  ${_diaryEntries![index]["title"]}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
