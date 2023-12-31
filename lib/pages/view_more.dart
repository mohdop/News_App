import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/Services/newsServices.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/pages/news_view.dart';
import 'package:news_app/widgets/color.dart';
import 'package:news_app/widgets/lnaguage.dart';

class ViewMore extends StatefulWidget {
  final String category;
  const ViewMore({super.key,required this.category});

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  List<Result>? results;
  String currentCountryCode = "us";
  @override
  void initState() { 
    super.initState();
   getNews(widget.category);
   initCurrentCountryCode();
  }
  getNews(String cat)async{
    results= await NewsServices().getNewsByCategories(cat,currentCountryCode);
  }

  

bool isFetchingCountryCode = false;

Future<void> initCurrentCountryCode() async {
  setState(() {
    isFetchingCountryCode = true;
  });

  try {
    String code = await NewsServices().getCurrentCountryCode();

    // Update UI with the current country code and fetched news
    setState(() {
      currentCountryCode = code.toLowerCase();
      isFetchingCountryCode = false;
    });
  } catch (error) {
    // Handle errors appropriately
    print("Error fetching data: $error");
    setState(() {
      isFetchingCountryCode = false;
    });
  }
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        "More news",
        style: GoogleFonts.noticiaText(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: blacky,
        ),
      ),
    ),
    body: FutureBuilder(
      future: getNews(widget.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Lottie.asset(
                       "assets/animations/newsPaper.json",
                    ),); 
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {

          return SingleChildScrollView(
            child: Column(
              children: results?.map((result) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                         onTap: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetails(result: result,),
                          ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: whitey,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey.withOpacity(0.4),
                              )
                            ]
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *0.11 ,
                                  width: MediaQuery.of(context).size.width *0.29 ,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: result.imageUrl==null ? AssetImage("assets/images/news.jpg") :  NetworkImage("${result.imageUrl.toString()}") as ImageProvider),
                                  ),
                                ),
                              ),Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                       Text(
                                        utf8.decode(result.title.toString().codeUnits),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.noticiaText(fontSize: 14, fontWeight:FontWeight.w900),
                                      ),
                                     SizedBox(height: 6,),
                                      Text(
                                        utf8.decode(result.description.toString().codeUnits),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.noticiaText(fontSize: 12,),
                                      ),
                                    
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList() ??
                  const [Text("data")],
            ),
          );
        }
      },
    ),
  );
}

}
