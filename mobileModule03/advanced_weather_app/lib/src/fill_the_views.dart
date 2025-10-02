import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';

class FillTheViews {
  static late Future<List<String>?> _locationInfo;
  static late ScrollController scrollController1;
  static late ScrollController scrollController2;
  static late Future<List<String>?> currentlyViewInfo;
  static late Future<List<List<String>>?> todayViewInfo;
  static late Future<List<List<String>>?> weeklyViewInfo;
  static final Map<int, String> _weatherDescriptions = {
    0: 'Clear sky',
    1: 'Mainly clear',
    2: 'Partly cloudy',
    3: 'Overcast',
    45: 'Fog',
    48: 'Depositing rime fog',
    51: 'Light drizzle',
    53: 'Moderate drizzle',
    55: 'Dense drizzle',
    56: 'Freezing light drizzle',
    57: 'Freezing dense drizzle',
    61: 'Slight rain',
    63: 'Moderate rain',
    65: 'Heavy rain',
    66: 'Freezing light rain',
    67: 'Freezing heavy rain',
    71: 'Slight snow fall',
    73: 'Moderate snow fall',
    75: 'Heavy snow fall',
    77: 'Snow grains',
    80: 'Slight rain showers',
    81: 'Moderate rain showers',
    82: 'Violent rain showers',
    85: 'Slight snow showers',
    86: 'Heavy snow showers',
    95: 'Thunderstorm',
    96: 'Thunderstorm with slight hail',
    99: 'Thunderstorm with heavy hail',
  };

  static String _getWeatherEmoji(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return '☀️';
      case 1:
        return '🌤️';
      case 2:
        return '⛅';
      case 3:
        return '☁️';
      case 45:
        return '🌫️';
      case 48:
        return '🌁';
      case 51:
      case 53:
      case 55:
        return '🌧️';
      case 56:
      case 57:
        return '🌨️';
      case 61:
      case 63:
      case 65:
        return '🌦️';
      case 66:
      case 67:
        return '🌨️';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return '❄️';
      case 80:
      case 81:
      case 82:
        return '🌧️';
      case 95:
        return '⛈️';
      case 96:
      case 99:
        return '🌩️';
      default:
        return '❓';
    }
  }

  static void init(BuildContext context, double? width, Location? location) {
    if (context.mounted) {
      scrollController1 = ScrollController();
      scrollController2 = ScrollController();
      _locationInfo = _getLocationInfo(context, width, location);
      currentlyViewInfo = _getCurrentlyViewInfo(context, width, location);
      todayViewInfo = _getTodayViewInfo(context, width, location);
      weeklyViewInfo = _getWeeklyViewInfo(context, width, location);
    }
  }

  static Future<List<String>?> _getLocationInfo(
    BuildContext context,
    double? width,
    Location? location,
  ) async {
    if (location == null) {
      return [];
    }
    try {
      final String geoUrl =
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=${location.latitude}&lon=${location.longitude}&accept-language=en';

      final http.Response geoResponse;
      try {
        geoResponse = await http.get(
          Uri.parse(geoUrl),
          headers: {'User-Agent': 'Mozilla/5.0 (compatible; MyFlutterApp/1.0)'},
        );
      } catch (error) {
        return null;
      }

      if (geoResponse.statusCode != 200) {
        return null;
      }
      while (width == null) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      final geoData = jsonDecode(geoResponse.body);
      if (geoData["address"] == null) {
        return [
          "Unknown location (${location.latitude}, ${location.longitude})",
        ];
      }

      String? city =
          geoData["address"]["city"] ??
          geoData["address"]["town"] ??
          geoData["address"]["village"];
      String? state =
          geoData["address"]["state"] ?? geoData["address"]["province"];
      if (state == city) {
        state = null;
      }
      String? country = geoData["address"]["country"];

      List<String> locationInfo = [];
      if (city != null) {
        locationInfo.add(city);
      }
      String text = "";
      if (state != null) {
        text = state;
        if (country != null) {
          text += ", $country";
        }
      } else if (country != null) {
        text = country;
      }
      if (text.isNotEmpty) {
        locationInfo.add(text);
      }

      return locationInfo;
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error'), backgroundColor: Colors.red),
        );
      }
      return [];
    }
  }

  static List<Widget> _getLocationInfoWidget(
    double width,
    double height,
    List<String> info,
  ) {
    List<Widget> locationInfo = [];
    if (info.isNotEmpty) {
      locationInfo.add(
        Text(
          info[0],
          style: TextStyle(
            fontSize: 30,
            color: const Color.fromARGB(255, 17, 7, 158),
          ),
        ),
      );
      if (info.length == 2) {
        locationInfo.add(Text(info[1], style: TextStyle(fontSize: 30)));
      }
    }
    return [
      Container(
        height: (height - 136) / 4,
        width: width,
        color: const Color.fromRGBO(70, 165, 194, 0.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: locationInfo,
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  static Future<List<Widget>> getTotalInfo(
    BuildContext context,
    double width,
    double height,
    Location? location,
    Future<List<dynamic>?> weatherInfo,
  ) async {
    var info = await _locationInfo;
    if (info == null) {
      return [Text("Error")];
    }
    List<Widget> totalInfo = _getLocationInfoWidget(width, height, info);
    var info2 = await weatherInfo;
    if (info2 == null) {
      return [Text("Error")];
    }
    totalInfo.addAll(
      info2 is List<String>
          ? [
            Container(
              height: (height - 136),
              width: width,
              color: const Color.fromRGBO(70, 165, 194, 0.5),
              child: Column(
                children: _getCurrentlyViewInfoWidget(width, height, info2),
              ),
            ),
          ]
          : info2 is List<List<String>>
          ? info2.length == 24
              ? _getTodayViewInfoWidget(width, height, info2)
              : info2.length == 7
              ? _getWeeklyViewInfoWidget(width, height, info2)
              : []
          : [],
    );
    return totalInfo;
  }

  static Future<List<String>?> _getCurrentlyViewInfo(
    BuildContext context,
    double? width,
    Location? location,
  ) async {
    try {
      List<String> currentlyViewInfo = [];
      int ctrl = 0;
      while (location == null) {
        if (ctrl++ == 10) {
          return [];
        }
        await Future.delayed(Duration(milliseconds: 100));
      }
      final String url =
          'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&current_weather=true';

      final http.Response response;
      try {
        response = await http.get(Uri.parse(url));
      } catch (error) {
        return null;
      }

      if (response.statusCode != 200) {
        return null;
      }

      while (width == null) {
        await Future.delayed(Duration(milliseconds: 100));
      }

      Map<String, dynamic> weather = json.decode(response.body);
      currentlyViewInfo.add("${weather["current_weather"]["temperature"]}°C");
      currentlyViewInfo.add("${weather["current_weather"]["weathercode"]}");
      currentlyViewInfo.add("${weather["current_weather"]["windspeed"]} km/h");
      return currentlyViewInfo;
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error'), backgroundColor: Colors.red),
        );
      }
      return [];
    }
  }

  static List<Widget> _getCurrentlyViewInfoWidget(
    double width,
    double height,
    List<String> info,
  ) {
    List<Widget> currentlyViewInfo = [];
    currentlyViewInfo.add(
      SizedBox(
        height: (height - 136) / 4,
        width: width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child:
                    (info.length == 3)
                        ? Text(
                          info[0],
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : null,
              ),
            );
          },
        ),
      ),
    );
    int weatherCode = (info.length == 3) ? int.parse(info[1]) : -1;
    String weatherDescription =
        _weatherDescriptions[weatherCode] ?? 'Unknown weather condition';
    currentlyViewInfo.add(
      SizedBox(
        height: (height - 136) / 4,
        width: width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child:
                    (info.length == 3)
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weatherDescription,
                              style: TextStyle(fontSize: 50),
                            ),
                            Text(
                              _getWeatherEmoji(weatherCode),
                              style: TextStyle(fontSize: 150),
                            ),
                          ],
                        )
                        : null,
              ),
            );
          },
        ),
      ),
    );
    currentlyViewInfo.add(
      SizedBox(
        height: (height - 136) / 4,
        width: width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child:
                    (info.length == 3)
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.air,
                              size: 30,
                              color: const Color.fromARGB(255, 17, 7, 158),
                            ),
                            const SizedBox(width: 10),
                            Text(info[2], style: TextStyle(fontSize: 24)),
                          ],
                        )
                        : null,
              ),
            );
          },
        ),
      ),
    );
    return currentlyViewInfo;
  }

  static Future<List<List<String>>?> _getTodayViewInfo(
    BuildContext context,
    double? width,
    Location? location,
  ) async {
    try {
      List<List<String>> todayViewInfo = [];
      int ctrl = 0;
      while (location == null) {
        if (ctrl++ == 10) {
          return [];
        }
        await Future.delayed(Duration(milliseconds: 100));
      }
      final String url =
          'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&hourly=temperature_2m,windspeed_10m,weathercode&timezone=auto';

      final http.Response response;
      try {
        response = await http.get(Uri.parse(url));
      } catch (error) {
        return null;
      }

      if (response.statusCode != 200) {
        return null;
      }

      while (width == null) {
        await Future.delayed(Duration(milliseconds: 100));
      }

      Map<String, dynamic> weather = json.decode(response.body);

      for (int number = 0; number < 24; number++) {
        todayViewInfo.add([
          " ${number.toString().padLeft(2, '0')}:00 ",
          " ${weather['hourly']['temperature_2m'][number]}°C ",
          "${weather["hourly"]["weathercode"][number]}",
          " ${weather['hourly']['windspeed_10m'][number]} km/h ",
        ]);
      }
      return todayViewInfo;
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error'), backgroundColor: Colors.red),
        );
      }
      return [];
    }
  }

  static List<Widget> _getTodayViewInfoWidget(
    double width,
    double height,
    List<List<String>> info,
  ) {
    List<Widget> todayViewInfo = [];
    List<FlSpot> flSpots = [];
    List<Widget> subTodayViewInfo = [];

    for (int i = 0; i < 24; i++) {
      flSpots.add(FlSpot(i.toDouble(), double.parse(info[i][1].split("°")[0])));
      subTodayViewInfo.add(
        Column(
          children: [
            SizedBox(
              height: (height - 136) / 16 * 3 / 4,
              width: width / 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    info[i][0],
                    style: TextStyle(fontSize: (height - 136) / 24 * 3 / 4),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (height - 136) / 8 * 3 / 4,
              width: width / 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _getWeatherEmoji(int.parse(info[i][2])),
                    style: TextStyle(fontSize: (height - 136) / 12 * 3 / 4),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (height - 136) / 16 * 3 / 4,
              width: width / 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    info[i][1],
                    style: TextStyle(
                      fontSize: (height - 136) / 24 * 3 / 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (height - 136) / 12 * 3 / 4,
              width: width / 4,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.air,
                      size: (height - 136) / 36 * 3 / 4,
                      color: const Color.fromARGB(255, 17, 7, 158),
                    ),
                    Text(
                      info[i][3],
                      style: TextStyle(fontSize: (height - 136) / 36 * 3 / 4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    int hourNum = -1;

    todayViewInfo.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 40),
        child: SizedBox(
          height: (height - 136) / 2,
          width: width,
          child: Column(
            children: [
              SizedBox(
                height: (height - 136) / 20,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Today temperature',
                    style: TextStyle(
                      fontSize: (height - 136) / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 9 * (height - 136) / 20,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${value.toInt()}°C ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: (height - 136) / 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: (height - 136) / 20,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (hourNum == value.toInt()) {
                              return const SizedBox.shrink();
                            }
                            hourNum = value.toInt();
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Transform.rotate(
                                angle: -0.5,
                                child: Text(
                                  "${value.toInt().toString().padLeft(2, '0')}:00",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: (height - 136) / 80,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                          strokeWidth: 2,
                          dashArray: [4, 5],
                        );
                      },
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                          strokeWidth: 2,
                          dashArray: [4, 5],
                        );
                      },
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        color: Colors.orange,
                        barWidth: 2,
                        spots: flSpots,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: Colors.white,
                              strokeWidth: 2,
                              strokeColor: Colors.orange,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    todayViewInfo.add(
      Container(
        height: (height - 136) / 4,
        width: width,
        color: const Color.fromRGBO(70, 165, 194, 0.5),
        child: Scrollbar(
          controller: scrollController1,
          thumbVisibility: true,
          child: ListView(
            controller: scrollController1,
            scrollDirection: Axis.horizontal,
            children: subTodayViewInfo,
          ),
        ),
      ),
    );
    return todayViewInfo;
  }

  static Future<List<List<String>>?> _getWeeklyViewInfo(
    BuildContext context,
    double? width,
    Location? location,
  ) async {
    try {
      List<List<String>> weeklyViewInfo = [];
      int ctrl = 0;
      while (location == null) {
        if (ctrl++ == 10) {
          return [];
        }
        await Future.delayed(Duration(milliseconds: 100));
      }
      final String url =
          'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=auto';

      final http.Response response;
      try {
        response = await http.get(Uri.parse(url));
      } catch (error) {
        return null;
      }

      if (response.statusCode != 200) {
        return null;
      }

      while (width == null) {
        await Future.delayed(Duration(milliseconds: 100));
      }

      Map<String, dynamic> weather = json.decode(response.body);
      List<String> dateList;

      for (int number = 0; number < 7; number++) {
        dateList = weather['daily']['time'][number].split("-");
        weeklyViewInfo.add([
          " ${dateList[2]}/${dateList[1]} ",
          " ${weather['daily']['temperature_2m_max'][number]}°C ",
          " ${weather['daily']['temperature_2m_min'][number]}°C ",
          " ${weather["daily"]["weathercode"][number]}",
        ]);
      }
      return weeklyViewInfo;
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error'), backgroundColor: Colors.red),
        );
      }
      return [];
    }
  }

  static List<Widget> _getWeeklyViewInfoWidget(
    double width,
    double height,
    List<List<String>> info,
  ) {
    List<Widget> weeklyViewInfo = [];
    List<FlSpot> flSpots1 = [];
    List<FlSpot> flSpots2 = [];
    List<String> dates = [];
    List<Widget> subWeeklyViewInfo = [];

    for (int i = 0; i < 7; i++) {
      flSpots1.add(
        FlSpot(i.toDouble(), double.parse(info[i][1].split("°")[0])),
      );
      flSpots2.add(
        FlSpot(i.toDouble(), double.parse(info[i][2].split("°")[0])),
      );
      dates.add(info[i][0]);
      subWeeklyViewInfo.add(
        Column(
          children: [
            SizedBox(
              height: (height - 136) / 20,
              width: width / 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    info[i][0],
                    style: TextStyle(fontSize: (height - 136) / 30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (height - 136) / 10,
              width: width / 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _getWeatherEmoji(int.parse(info[i][3])),
                    style: TextStyle(fontSize: (height - 136) / 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (height - 136) / 20,
              width: width / 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    info[i][1],
                    style: TextStyle(
                      fontSize: (height - 136) / 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 236, 19, 3),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: (height - 136) / 20,
              width: width / 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    info[i][2],
                    style: TextStyle(
                      fontSize: (height - 136) / 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 20, 10, 172),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    int dateNum = -1;
    weeklyViewInfo.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 40),
        child: SizedBox(
          height: (height - 136) / 2,
          width: width,
          child: Column(
            children: [
              SizedBox(
                height: (height - 136) / 20,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Weekly temperature',
                    style: TextStyle(
                      fontSize: (height - 136) / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8 * (height - 136) / 20,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${value.toInt()}°C ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: (height - 136) / 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: (height - 136) / 20,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (dateNum == value.toInt()) {
                              return const SizedBox.shrink();
                            }
                            dateNum = value.toInt();
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Transform.rotate(
                                angle: -0.5,
                                child: Text(
                                  dates[value.toInt()],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: (height - 136) / 80,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                          strokeWidth: 2,
                          dashArray: [4, 5],
                        );
                      },
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                          strokeWidth: 2,
                          dashArray: [4, 5],
                        );
                      },
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        color: const Color.fromARGB(255, 236, 19, 3),
                        barWidth: 2,
                        spots: flSpots1,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: Colors.white,
                              strokeWidth: 2,
                              strokeColor: const Color.fromARGB(
                                255,
                                236,
                                19,
                                3,
                              ),
                            );
                          },
                        ),
                      ),
                      LineChartBarData(
                        color: const Color.fromARGB(255, 20, 10, 172),
                        barWidth: 2,
                        spots: flSpots2,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: Colors.white,
                              strokeWidth: 2,
                              strokeColor: const Color.fromARGB(
                                255,
                                20,
                                10,
                                172,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: (height - 136) / 20,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 4,
                                color: const Color.fromARGB(255, 20, 10, 172),
                              ),
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 20, 10, 172),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          const Text('Min temperature'),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 4,
                                color: const Color.fromARGB(255, 236, 19, 3),
                              ),
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 236, 19, 3),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          const Text('Max temperature'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    weeklyViewInfo.add(
      Container(
        height: (height - 136) / 4,
        width: width,
        color: const Color.fromRGBO(70, 165, 194, 0.5),
        child: Scrollbar(
          controller: scrollController2,
          thumbVisibility: true,
          child: ListView(
            controller: scrollController2,
            scrollDirection: Axis.horizontal,
            children: subWeeklyViewInfo,
          ),
        ),
      ),
    );
    return weeklyViewInfo;
  }
}
