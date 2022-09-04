// ignore_for_file: must_be_immutable

import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  dynamic data;
  DetailScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data!['Country Name']),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Card(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        ReusableRow(
                            title: 'Country Name',
                            value: widget.data!['Country Name']),
                        ReusableRow(
                            title: 'Total Cases',
                            value: widget.data!['Total Cases'].toString()),
                        ReusableRow(
                            title: 'Total Deaths',
                            value: widget.data!['Total Deaths'].toString()),
                        ReusableRow(
                            title: 'Total Recovered',
                            value: widget.data!['Recovered'].toString()),
                        ReusableRow(
                            title: 'Active Cases',
                            value: widget.data!['Active'].toString()),
                        ReusableRow(
                            title: 'Critical Cases',
                            value: widget.data!['Critical'].toString()),
                        ReusableRow(
                            title: 'Today Recovered',
                            value: widget.data!['Today Recovered'].toString()),
                        ReusableRow(
                            title: 'Total Tests Conducted',
                            value: widget.data!['Total Tests Conducted']
                                .toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.data!['Country Flag']),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
