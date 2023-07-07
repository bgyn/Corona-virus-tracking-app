import 'dart:convert';

import 'package:covid_tracker_app/Models/worldsteate_model.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker_app/service/utilities/api_url.dart';

class StatesServices {
  Future<WorldStateModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(ApiUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(ApiUrl.countriesApi));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 503) {
      return data;
    } else {
      print('error');
      throw Exception('Error');
    }
  }
}
