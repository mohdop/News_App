import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/widgets/color.dart';

class CountryNews extends StatelessWidget {
  final Result result;

  const CountryNews({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onDoubleTap: (){},
        child: Container(
          
          margin: const EdgeInsets.all(8),
          width: 300,
          height: 350,
          
          decoration: BoxDecoration(
            color: whitey,
          boxShadow:  [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
           offset: Offset(4, 8), // changes position of shadow
        ),
      ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10
                    ),
                   image: DecorationImage(
                    
                    image: result.imageUrl != null
                        ? NetworkImage(result.imageUrl!)
                        : AssetImage('assets/images/news.jpg') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    utf8.decode(result.title.toString().codeUnits),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.noticiaText(fontSize: 16, fontWeight:FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                   result.description != null ?  utf8.decode(result.description.toString().codeUnits) : "Follow Up",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.noticiaText(fontSize: 14),
                  ),
                ),Padding(padding: EdgeInsets.all(8),
                child:Text( result.country != null ?  utf8.decode(result.country!.first.toString().codeUnits).toUpperCase() : ""),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(CupertinoIcons.clock,color: Colors.grey,),
                      Text( result.pubDate != null ?  utf8.decode(result.pubDate!.hour.toString().codeUnits)+" hours ago"  : "fews hours ago"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

