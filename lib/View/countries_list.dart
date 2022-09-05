import 'package:Virus_Stats/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/stats.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WorldStats worldstats = WorldStats();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Back'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: worldstats.fetchCountriesList(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 10,
                                      width: 85,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 85,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100);
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          dynamic countryName =
                              snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RoutesNames.country_detail_screen,
                                        arguments: {
                                          'Country Flag': snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          'Country Name': snapshot.data![index]
                                              ['country'],
                                          'Total Cases': snapshot.data![index]
                                              ['cases'],
                                          'Total Deaths': snapshot.data![index]
                                              ['deaths'],
                                          'Recovered': snapshot.data![index]
                                              ['cases'],
                                          'Active': snapshot.data![index]
                                              ['active'],
                                          'Critical': snapshot.data![index]
                                              ['critical'],
                                          'Today Recovered': snapshot
                                              .data![index]['todayRecovered'],
                                          'Total Tests Conducted':
                                              snapshot.data![index]['tests'],
                                        });
                                  },
                                  child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      )),
                                )
                              ],
                            );
                          } else if (countryName
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RoutesNames.country_detail_screen,
                                        arguments: {
                                          'Country Flag': snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          'Country Name': snapshot.data![index]
                                              ['country'],
                                          'Total Cases': snapshot.data![index]
                                              ['cases'],
                                          'Total Deaths': snapshot.data![index]
                                              ['deaths'],
                                          'Recovered': snapshot.data![index]
                                              ['cases'],
                                          'Active': snapshot.data![index]
                                              ['active'],
                                          'Critical': snapshot.data![index]
                                              ['critical'],
                                          'Today Recovered': snapshot
                                              .data![index]['todayRecovered'],
                                          'Total Tests Conducted':
                                              snapshot.data![index]['tests'],
                                        });
                                  },
                                  child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      )),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  }))
        ],
      )),
    );
  }
}
