import 'dart:convert';
import 'package:favicon/favicon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/widgets/color.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcePage extends StatefulWidget {
  final Result result;
  const SourcePage({super.key, required this.result});

  @override
  State<SourcePage> createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  Favicon? iconUrl;
  @override
  void initState() {
    super.initState();
    fetchIcon(widget.result.url);
  }

  fetchIcon(String url) async {
    iconUrl = await FaviconFinder.getBest(url);
    setState(() {}); // Add this to trigger a rebuild after fetching the icon
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: iconUrl == null? NetworkImage("https://littlebeam.com/cdn/shop/articles/Dark_Blue_Red_White_Generic_News_General_News_Logo.png?v=1691342691"): NetworkImage("${iconUrl?.url}",),
                    )
                  ),
                ),Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.22,),
                       CircleAvatar(
                        radius: 90,
                        backgroundColor: whitey,
                         child:  CircleAvatar(
                          backgroundImage: iconUrl == null? NetworkImage("https://littlebeam.com/cdn/shop/articles/Dark_Blue_Red_White_Generic_News_General_News_Logo.png?v=1691342691"): NetworkImage("${iconUrl?.url}"),
                          radius: 80,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                         child: Container(
                          decoration: BoxDecoration(
                            color: blacky,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(utf8.decode(widget.result.name.toString().codeUnits),style: GoogleFonts.poppins(fontSize:22,color: purply,fontWeight: FontWeight.bold)),
                          )),
                       ),
                       SizedBox(height: 25,),
                       Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("About us:",style: GoogleFonts.poppins(fontSize:16,color: blacky,fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(utf8.decode(widget.result.description.toString().codeUnits),style: GoogleFonts.poppins(fontSize:16,color: blacky,fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Categories:",style: GoogleFonts.poppins(fontSize:16,color: blacky,fontWeight: FontWeight.bold)),
                      ),
                      Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: widget.result.category.map((category) {
                                        return Row(
                                          children: [
                                            Padding(padding: EdgeInsets.all(2),
                                            child: Text("•"),
                                            ),
                                            Text(utf8.decode(category.name.toString().codeUnits), style: GoogleFonts.poppins(fontSize:16, color: blacky, fontWeight: FontWeight.w900)),
                                            
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      InkWell(
                        onTap: () {
                          launch(widget.result.url);
                        },
                        child:Text("Click to visit website",style: GoogleFonts.poppins(fontSize:16, color: purply, fontWeight: FontWeight.w700)) ,
                      )
                     
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ) ,
    );
  }
}

/**
 *  import 'package:favicon/favicon.dart';
var iconUrl = await FaviconFinder.getBest('https://www.mashable.com');
print(iconUrl);
 */
