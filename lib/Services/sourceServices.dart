import 'package:news_app/models/source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SourcesServices {
  var client = http.Client();
  //method to list all the news sources
  Future<List<Result>> getNewsSource() async {
  var url = Uri.parse("https://newsdata.io/api/1/sources?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a");
  var response = await client.get(url);

  if (response.statusCode == 200) {
    var resp = response.body;
    var resultsList = json.decode(resp)['results'];
    
    if (resultsList is List) {
      return List<Result>.from(resultsList.map((item) => Result.fromJson(item)));
    } else {
      return [];
    }
  } else {
    // Throw an exception and catch it in UI
    throw Exception('Failed to load news');
  }
}
}