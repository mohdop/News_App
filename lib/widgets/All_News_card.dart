import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Services/newsServices.dart';
import 'package:news_app/pages/news_view.dart';
import 'package:news_app/pages/view_more.dart';
import 'package:news_app/widgets/color.dart';
import 'package:news_app/widgets/shimmer_cards.dart';
import '../models/news.dart';

class AllNewsCard extends StatefulWidget {
  const AllNewsCard({Key? key});

  @override
  State<AllNewsCard> createState() => _AllNewsCardState();
}

class _AllNewsCardState extends State<AllNewsCard> {
  List<Result>? allResult;
  String currentCountryCode = "Loading...";

  @override
  void initState() {
    super.initState();
    initCurrentCountryCode();
  }

  Future<void> initCurrentCountryCode() async {
    try {
      String code = await NewsServices().getCurrentCountryCode();
      if (allResult == null) {
        allResult = await NewsServices().getAllNews(code);
        print('Results fetched: $allResult');
      } else {
        allResult = await NewsServices().getAllNews(code);
      }

      setState(() {
        currentCountryCode = code.toLowerCase();
      });
    } catch (e) {
      print('Error fetching results: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800, // Set a fixed height or adjust as needed
      child: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: allResult?.map((result) {
                return IndividualNewsCard(result: result);
              }).toList() ??
                  [ShimmerNewsNewsCard(), ShimmerNewsNewsCard(), ShimmerNewsNewsCard()],
            ),
          ),
        ],
      ),
    );
  }
}
class IndividualNewsCard extends StatelessWidget {
  final Result result;

  const IndividualNewsCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetails(result: result,),
      ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.8,
          decoration: BoxDecoration(
            color: whitey,
            boxShadow: [
              BoxShadow(color: Colors.grey[300]!, blurRadius: 8),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.category?.isNotEmpty == true
                            ? result.category!.map((cat) => cat.toString().split('.').last).join(', ')
                            : 'No Category',
                        style: GoogleFonts.oswald(color: Colors.grey[400]),
                      ),
                      SizedBox(height: 20),
                      Text(
                        utf8.decode(result.title!.toString().codeUnits),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: blacky,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 130,
                width: 170,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: result.imageUrl != null
                        ? NetworkImage(result.imageUrl!)
                        : AssetImage('assets/images/news.jpg') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

