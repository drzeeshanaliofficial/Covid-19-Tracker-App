import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Services/stats.dart';


class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorlist = const <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    WorldStats worldstats = WorldStats();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
              future: worldstats.fetchWorldStatsRecords(),
              builder: (BuildContext context,
                  AsyncSnapshot<WorldStatsModel> snapshot) {
                if (!snapshot.hasData) {
                  return const Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total Patients":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered Patients": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          chartRadius: 140,
                          colorList: colorlist,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .04),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Total Cases',
                                  value: snapshot.data!.cases.toString(),
                                ),
                                ReusableRow(
                                  title: 'Total Deaths',
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                ReusableRow(
                                  title: 'Total Recovered Patients',
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                ReusableRow(
                                  title: 'Active Cases',
                                  value: snapshot.data!.active.toString(),
                                ),
                                ReusableRow(
                                  title: 'Critical Patients',
                                  value: snapshot.data!.critical.toString(),
                                ),
                                ReusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString(),
                                ),
                                ReusableRow(
                                  title: 'Total Recovered Patients',
                                  value: snapshot.data!.recovered.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesNames.countries_list);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Track Country',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        const Text(
                          'Developed by Zeeshan Ali',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
