import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Services/newsServices.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/pages/news_view.dart';
import 'package:news_app/widgets/color.dart';

class ViewMore extends StatefulWidget {
  final String category;
  const ViewMore({super.key, required this.category});

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  List<Result>? results;
  @override
  void initState() { 
    super.initState();
   getNews(widget.category);
  }
  getNews(String cat)async{
   if (widget.category == "") {
     results= await NewsServices().getNewsEvery();
   }else if(widget.category != ""){
    results= await NewsServices().getNewsByCategories(widget.category);
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
          return Center(child: CircularProgressIndicator()); // Show a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Assuming getNews returns void, you might need to modify it
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
                                blurRadius: 7,
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
