import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/Services/newsServices.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/widgets/color.dart';
import 'package:news_app/widgets/widgets.dart';

class SearchNews extends StatefulWidget {
  const SearchNews({super.key});

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  TextEditingController searchTextEditingController = TextEditingController();
  String query='';
  List<String> data=["Orange","Banana","HoneyDew"];
  List<Result>? searchResults;


  
 onQueryChanged(String query) async {
  setState(() {
    searchResults = []; // Clear previous results
  });

  if (query.isNotEmpty) {
    try {
      List<Result> newsResults = await NewsServices().getNewsKeyword(query);
      print("Fetched results: $newsResults"); // Print the results
      setState(() {
        searchResults = newsResults;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {}); // Force a rebuild
      });

    } catch (error) {
      print("Error fetching search results: $error");
      // Handle error, maybe show an error message to the user
    }
  }
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          TextFormField(
                  controller: searchTextEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(CupertinoIcons.search, color: blacky,),
                    labelText: "Search for news ex: sports",
                    labelStyle: GoogleFonts.noticiaText(color: blacky),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: purply!), borderRadius: BorderRadius.circular(18)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: blacky!), borderRadius: BorderRadius.circular(18)),
                  ),
                  onChanged: onQueryChanged
                ),
          Expanded(
            child:ListView.builder(
            itemCount: searchResults?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchResults![index].link.toString() ?? 'no good boi'),
                // Add more fields from Result class as needed
              );
            },
          ),


          ),
        ],
      ),
    );
  }
}
