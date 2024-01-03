import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:news_app/models/news.dart';

String baseUrl="https://newsdata.io/api/1/news?";
class NewsServices{
  var client = http.Client();


  Future<List<Result>> getNewsByCategory(String countryCode,String category) async {
    var url = Uri.parse("https://newsdata.io/api/1/news?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a&category=$category&country=$countryCode");
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
  Future<List<Result>> getNewsByCategories(String category,String country) async {
    var url = Uri.parse("https://newsdata.io/api/1/news?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a&category=$category&country=$country");
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

  Future<List<Result>> getAllNews(String language) async {
    var url = Uri.parse("https://newsdata.io/api/1/news?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a");
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

  Future<String> getCurrentCountryCode() async {
    // Get permission from the user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if it's not granted
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      // Handle the case where the user denied permission
      return "Permission denied";
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Convert the location into a list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Extract the country code from the first placemark
    String? countryCode = placemarks.isNotEmpty ? placemarks[0].isoCountryCode : null;

    if (countryCode != null) {
      return countryCode;
    } else {
      return "Unknown";
    }
  }

  Future<List<Result>> getNewsKeyword(String keyword) async {
    try {
      var url = Uri.parse("https://newsdata.io/api/1/news?apikey=pub_3352193d23b5e4c9531db2c90947e2e1ed31a");
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var resp = response.body;
        var allResults = List<Result>.from(json.decode(resp)['results']?.map((item) => Result.fromJson(item)) ?? []);

        // Filter results based on the keyword
        var filteredResults = allResults.where((result) =>
            result.keywords != null && result.keywords!.contains(keyword)).toList();

        return filteredResults;
      } else {
        print("Error response status code: ${response.statusCode}");
        print("Error response body: ${response.body}");
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print("Error fetching search results: $error");
      throw Exception('Failed to load news');
    }
  }
  
}

