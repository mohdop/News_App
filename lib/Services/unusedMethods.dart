//   Future<List<Result>> getNews(String language,String category) async {
//   var url = Uri.parse("https://newsdata.io/api/1/news?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a&category=$category&language=$language");
//   var response = await client.get(url);

//   if (response.statusCode == 200) {
//     var resp = response.body;
//     var resultsList = json.decode(resp)['results'];
    
//     if (resultsList is List) {
//       return List<Result>.from(resultsList.map((item) => Result.fromJson(item)));
//     } else {
//       return [];
//     }
//   } else {
//     // Throw an exception and catch it in UI
//     throw Exception('Failed to load news');
//   }
// }
// Future<List<Result>> getCountryNews(String countryCode) async {
//   var url = Uri.parse("https://newsdata.io/api/1/news?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a&category=top&language=fr&country=$countryCode");
//   var response = await client.get(url);

//   if (response.statusCode == 200) {
//     var resp = response.body;
//     var resultsList = json.decode(resp)['results'];
    
//     if (resultsList is List) {
//       return List<Result>.from(resultsList.map((item) => Result.fromJson(item)));
//     } else {
//       return [];
//     }
//   } else {
//     // Throw an exception and catch it in UI
//     throw Exception('Failed to load news');
//   }
// }

// Future<List<Result>> getNewsEvery(String lang) async {
//   var url = Uri.parse("https://newsdata.io/api/1/news?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a&language=$lang");
//   var response = await client.get(url);

//   if (response.statusCode == 200) {
//     var resp = response.body;
//     var resultsList = json.decode(resp)['results'];
    
//     if (resultsList is List) {
//       return List<Result>.from(resultsList.map((item) => Result.fromJson(item)));
//     } else {
//       return [];
//     }
//   } else {
//     // Throw an exception and catch it in UI
//     throw Exception('Failed to load news');
//   }
// }