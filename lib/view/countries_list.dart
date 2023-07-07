import 'package:covid_tracker_app/service/states_service.dart';
import 'package:covid_tracker_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  var stateService = StatesServices();
  final SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        title: Text("Countries"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: SearchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: 'Search with country name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
                child: FutureBuilder<List<dynamic>>(
              future: stateService.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (SearchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new DetailScreen(
                                            name: snapshot.data![index]
                                                ['country'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            cases: snapshot.data![index]
                                                ['cases'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                            death: snapshot.data![index]
                                                ['deaths'],
                                            recovered: snapshot.data![index]
                                                ['recovered'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            todaysCases: snapshot.data![index]
                                                ['todayCases'],
                                            todayDeath: snapshot.data![index]
                                                ['todayDeaths'],
                                          ))),
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']
                                    .toString()),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 202, 8, 8)),
                                  height: 50,
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      snapshot.data![index]['country'],
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(SearchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  snapshot.data![index]['country'].toString()),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 202, 8, 8)),
                                height: 50,
                                width: 70,
                                child: Center(
                                  child: Text(
                                    snapshot.data![index]['country'],
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    },
                  );
                } else {
                  return Expanded(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                  // return ListView.builder(
                  //   itemCount: 20,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Shimmer.fromColors(
                  //         child: Column(
                  //           children: [
                  //             ListTile(
                  //               title: Container(
                  //                 height: 19,
                  //                 width: 89,
                  //                 color: Colors.white,
                  //               ),
                  //               subtitle: Container(
                  //                 height: 10,
                  //                 width: 89,
                  //                 color: Colors.white,
                  //               ),
                  //               leading: Container(
                  //                 height: 50,
                  //                 width: 50,
                  //                 color: Colors.white,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //         baseColor: Colors.grey.shade700,
                  //         highlightColor: Colors.grey.shade100);
                  //   },
                  // );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
