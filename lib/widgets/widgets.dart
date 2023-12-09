import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/news_view.dart';
import 'package:news_app/widgets/All_News_card.dart';
import '../models/news.dart';
import 'color.dart';


class CategoryCard extends StatefulWidget {
  final String? categ;
  
  const CategoryCard({this.categ});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}


class _CategoryCardState extends State<CategoryCard> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:6.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isTapped ? blacky:Colors.grey[200] ,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("  "+widget.categ!+"  ",style: TextStyle(color: isTapped?   Colors.grey[300]:Colors.grey[500],fontSize: 18 ),),
          ),
        ),
      ),
    );
  }
}





class NewsCard extends StatelessWidget {
  final Result result;

  const NewsCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
        onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsDetails(result: result,),
        ));
        },
          child: Container(
            
            margin: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.45,
            
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
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                     result.description != null ?  utf8.decode(result.description.toString().codeUnits) : "Follow Up",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.noticiaText(fontSize: 14),
                    ),
                  ),Padding(padding: EdgeInsets.all(8),
                  child:Row(
                    children: [
                       Icon(Icons.location_pin,color: Colors.grey,),
                      Text( result.country != null ?  utf8.decode(result.country!.first.toString().codeUnits).toUpperCase() : ""),
                    ],
                  ),
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
      ],
    );
  }
}



class CategoryRow extends StatefulWidget {
  
  const CategoryRow({super.key}) ;

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  // Define a list of categories
  List<String> categories = ["All", "Technology", "Sports", "Entertainment", "Health", "Business", ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((category) {
            // Generate a CategoryCard for each category in the list
            return CategoryCard(categ: category);
          }).toList(),
        ),
      ),
    );
  }
}
