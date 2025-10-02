import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'src/fill_the_views.dart';
import 'src/where_are_we.dart';
import 'src/searcher.dart';
import 'src/location.dart';
import 'src/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'weather_app', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late TabController _tabController;
  late double _height;
  double? _width;
  List<dynamic> _suggestionsList = [];
  Location? _currentlocation;
  Location? _location;
  bool _isValidSearch = true;
  bool _accessGPS = true;
  bool _accessAPI = true;

  Future<void> _currentLocationOperation() async {
    Position? position = await WhereAreWe.getCurrentLocation(context);
    setState(() {
      if (_accessGPS = position != null) {
        _location = Location(position!.latitude, position.longitude);
        _isValidSearch = true;
      } else {
        _isValidSearch = false;
      }
      if (_currentlocation != _location || !_accessAPI) {
        FillTheViews.init(context, _width, _location);
        _currentlocation = _location;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController();
    FillTheViews.init(context, _width, _location);
    _currentLocationOperation();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    FillTheViews.scrollController1.dispose();
    FillTheViews.scrollController2.dispose();
    super.dispose();
  }

  Future<void> _click() async {
    if (_searchController.text.isEmpty) {
      await _currentLocationOperation();
    } else {
      _accessGPS = true;
      _location = await Searcher.getCoordinatesFromInput(
        context,
        _searchController.text,
      );
      _isValidSearch = _location != null;
      if (_isValidSearch) {
        if (_location!.latitude == -91) {
          _accessAPI = false;
          _location = null;
        } else {
          _accessAPI = true;
        }
      }
      if (_currentlocation != _location || !_accessAPI) {
        if (mounted) {
          FillTheViews.init(context, _width, _location);
          _currentlocation = _location;
        }
      }
    }
    setState(() {
      _searchController.text = "";
      _suggestionsList.clear();
    });
  }

  TextField _title() => TextField(
    controller: _searchController,
    onSubmitted: (_) => _click(),
    onChanged: (value) async {
      int cursorPosition = _searchController.selection.baseOffset;
      _searchController.text = value.trim();
      for (int i = _searchController.text.length - 2; i >= 0; i--) {
        if (_searchController.text[i] == ',' &&
            _searchController.text[i + 1] != ' ') {
          _searchController.text =
              "${_searchController.text.substring(0, i)}, ${_searchController.text.substring(i + 1)}";
          cursorPosition++;
          break;
        }
      }
      _searchController.selection = TextSelection.collapsed(
        offset:
            cursorPosition > _searchController.text.length
                ? _searchController.text.length
                : cursorPosition,
      );
      _suggestionsList = await Searcher.getSuggestions(
        context,
        _searchController.text,
      );
      if (_suggestionsList.isNotEmpty && _suggestionsList[0] is String) {
        if (_accessAPI) {
          _accessAPI = false;
          setState(() {});
        }
        _suggestionsList.clear();
      } else {
        _accessAPI = true;
        setState(() {});
      }
    },
    decoration: const InputDecoration(
      icon: Icon(Icons.search, color: Colors.white),
      labelText: 'Search location',
      labelStyle: TextStyle(color: Colors.white38),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: InputBorder.none,
    ),
    style: const TextStyle(color: Colors.white),
  );

  List<Widget> _actions() => [
    Container(width: 2, height: 35, color: Colors.white),
    IconButton(
      icon: const Icon(Icons.send, color: Colors.white),
      onPressed: () => _click(),
    ),
  ];

  BottomAppBar _bottomAppBar() => BottomAppBar(
    color: const Color.fromARGB(255, 137, 219, 230),
    child: TabBar(
      controller: _tabController,
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(icon: Icon(Icons.settings), text: "Currently"),
        Tab(icon: Icon(Icons.today), text: "Today"),
        Tab(icon: Icon(Icons.calendar_view_week), text: "Weekly"),
      ],
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
    ),
  );

  Padding _suggestionsTable() {
    int suggestionsLength;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color.fromRGBO(70, 165, 194, 0.5),
        height:
            _suggestionsList.length >= 5
                ? (_height - 136 > 304 ? 304 : _height - 136)
                : (_height - 136 >
                        _suggestionsList.length * 60 +
                            _suggestionsList.length -
                            1
                    ? _suggestionsList.length * 60 + _suggestionsList.length - 1
                    : _height - 136),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              suggestionsLength =
                  _suggestionsList.length >= 5 ? 5 : _suggestionsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListTile(
                    title: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  color: Color.fromARGB(255, 221, 218, 218),
                                ),
                                const SizedBox(width: 30),
                                RichText(
                                  text: Utils.highlightText(
                                    _suggestionsList[index]["location"],
                                    _searchController.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () async {
                      _searchController.text =
                          _suggestionsList[index]["location"];
                      _suggestionsList = await Searcher.getSuggestions(
                        context,
                        _searchController.text,
                      );
                      if (_suggestionsList.isNotEmpty &&
                          _suggestionsList[0] is String) {
                        _accessAPI = false;
                        _suggestionsList.clear();
                      } else {
                        _accessAPI = true;
                      }
                      setState(() {});
                    },
                  ),
                ),
                if (index != suggestionsLength - 1)
                  const Divider(color: Colors.grey, height: 1, thickness: 1),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _page(Future<List<dynamic>?> info) {
    return FutureBuilder<List<Widget>?>(
      future: FillTheViews.getTotalInfo(
        context,
        _width!,
        _height,
        _currentlocation,
        info,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Utils.layoutBuilder(
              _width!,
              'Error: ${snapshot.error}',
              40,
              Colors.red,
            ),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty && snapshot.data![0] is Text) {
            _accessAPI = false;
            return Utils.error(
              _width!,
              'The service connection is lost, please check',
              'your internet connection or try again later',
            );
          }
          _accessAPI = true;
          return SingleChildScrollView(child: Column(children: snapshot.data!));
        } else {
          return Center(
            child: Utils.layoutBuilder(
              _width!,
              'No data available',
              40,
              Colors.red,
            ),
          );
        }
      },
    );
  }

  Column _body() => Column(
    children: [
      Expanded(
        child:
            _accessGPS
                ? (_accessAPI
                    ? (_isValidSearch
                        ? TabBarView(
                          controller: _tabController,
                          children: [
                            _page(FillTheViews.currentlyViewInfo),
                            _page(FillTheViews.todayViewInfo),
                            _page(FillTheViews.weeklyViewInfo),
                          ],
                        )
                        : Utils.error(
                          _width!,
                          'Could not find any result for the supplied',
                          'address or coordinates',
                        ))
                    : Utils.error(
                      _width!,
                      'The service connection is lost, please check',
                      'your internet connection or try again later',
                    ))
                : Utils.error(
                  _width!,
                  'Geolocation is not available, please enable',
                  'it in your App settings',
                ),
      ),
    ],
  );

  Stack _stack() => Stack(
    children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      (_suggestionsList.isNotEmpty) ? _suggestionsTable() : _body(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 38, 99, 134),
        title: _width! < 60 ? null : _title(),
        actions: _width! < 60 ? null : _actions(),
      ),
      body: _height < 136 ? null : _stack(),
      bottomNavigationBar:
          _height < 80 - MediaQuery.of(context).padding.top
              ? null
              : _bottomAppBar(),
    );
  }
}
