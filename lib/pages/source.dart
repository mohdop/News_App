// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Services/sourceServices.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/pages/source_page.dart';
import 'package:news_app/widgets/color.dart';

class NewsSource extends StatefulWidget {
  const NewsSource({Key? key}) : super(key: key);

  @override
  State<NewsSource> createState() => _NewsSourceState();
}

class _NewsSourceState extends State<NewsSource> {
  List<Result>? sources;

  @override
  void initState() {
    super.initState();
    fetchSources();
  }

  Future<void> fetchSources() async {
    try {
      List<Result> newsResults = await SourcesServices().getNewsSource();
      setState(() {
        sources = newsResults;
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whitey,
         centerTitle: true,
        title: Text("News sources",style: GoogleFonts.noticiaText(color: blacky,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (sources != null)
              StaggeredGrid.count(
                crossAxisCount: 2,
                children:  sources!.map((source) {
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: whitey,
                          boxShadow:[
                            BoxShadow(
                              color: Colors.grey[200]!,
                              offset: Offset(4, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),child: Column(
                          children: [
                            Center(child: Padding(
                              padding: const EdgeInsets.only(top:28.0),
                              child: Text(  utf8.decode(source.name.toString().codeUnits), style: GoogleFonts.noticiaText(color: blacky,fontWeight: FontWeight.bold),),
                            )),
                             SizedBox(height: 25,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SourcePage(result: source)
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: blacky,
                                  ),
                                    child: Expanded(
                                      child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("See more", style: GoogleFonts.noticiaText(color: whitey,fontWeight: FontWeight.bold)),
                                    )),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
            if (sources == null)
              // Handle the case when sources is null (loading or error)
              Center(child: CircularProgressIndicator(color: purply,)),
            
          ],
        ),
      ),
    );
  }
}
