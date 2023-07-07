import 'package:covid_tracker_app/service/states_service.dart';
import 'package:covid_tracker_app/view/world_states.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailScreen extends StatefulWidget {
  final name;
  final cases,
      todaysCases,
      death,
      active,
      todayRecovered,
      recovered,
      critical,
      todayDeath;
  DetailScreen(
      {required this.name,
      required this.todaysCases,
      required this.death,
      required this.active,
      required this.todayRecovered,
      required this.recovered,
      required this.cases,
      required this.critical,
      required this.todayDeath});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var stateService = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: Column(
        children: [
          PieChart(
            dataMap: {
              "Total": widget.death.toDouble(),
              "Recovered": widget.death.toDouble(),
              'Death': widget.death.toDouble(),
            },
            chartValuesOptions:
                ChartValuesOptions(showChartValuesInPercentage: true),
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            legendOptions: LegendOptions(
              legendPosition: LegendPosition.left,
            ),
            chartType: ChartType.ring,
            animationDuration: Duration(milliseconds: 1200),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.06),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ResuableRow(
                    title: 'Total',
                    value: widget.cases.toString(),
                  ),
                  ResuableRow(
                    title: 'Death',
                    value: widget.death.toString(),
                  ),
                  ResuableRow(
                    title: 'Recovered',
                    value: widget.recovered.toString(),
                  ),
                  ResuableRow(
                    title: 'Active',
                    value: widget.active.toString(),
                  ),
                  ResuableRow(
                    title: 'Critical',
                    value: widget.critical.toString(),
                  ),
                  ResuableRow(
                    title: 'Todays Death',
                    value: widget.todayDeath.toString(),
                  ),
                  ResuableRow(
                    title: 'Todays Recovered',
                    value: widget.todayRecovered.toString(),
                  ),
                  ResuableRow(
                    title: 'Todays Cases',
                    value: widget.todaysCases.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
