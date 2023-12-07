import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/Services/newsServices.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/pages/view_more.dart';
import 'package:news_app/widgets/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets/shimmer_cards.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentCountryCode = "Loading...";
  List<Result>? results;
  List<Result>? cresults;
  List<Result>? news_everywhere;

  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    initCurrentCountryCode();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  Future<void> initCurrentCountryCode() async {
    try {
      String code = await NewsServices().getCurrentCountryCode();
      if (results == null) {
        results = await NewsServices().getNews(code);
        cresults = await NewsServices().getCountryNews(code);
        news_everywhere = await NewsServices().getNewsEvery();
        print('Results fetched: $results');
      } else {
        results = await NewsServices().getNews(code);
        cresults = await NewsServices().getCountryNews(code);
        news_everywhere = await NewsServices().getNewsEvery();

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
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: Text("News",style: GoogleFonts.abel(color: purply,fontSize: 22),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController, 
        child: Column(
          children: [
           CategoryRow(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Trending ",style: GoogleFonts.noticiaText(color: blacky,fontWeight: FontWeight.bold,fontSize: 22),),
             
       InkWell(
        onTap: () {
           Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewMore(category: "Top")
          ));
        },
        child: Text('view more',style: GoogleFonts.noticiaText(color: purply,fontSize: 18,fontWeight: FontWeight.w500),)),
    
  ],
),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                 
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: results?.map((result) {
                        return NewsCard(result: result);
                      }).toList() ?? [ShimmerNewsCard(), ShimmerNewsCard(), ShimmerNewsCard()],
                    ),
                  ),            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Trending in $currentCountryCode",style: GoogleFonts.noticiaText(color: blacky,fontWeight: FontWeight.bold,fontSize: 22),),
             
       InkWell(
        onTap: () {
           Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewMore(category: "Top")
          ));
        },
        child: Text('view more',style: GoogleFonts.noticiaText(color: purply,fontSize: 18,fontWeight: FontWeight.w500),)),
    
  ],
),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: cresults?.map((cresult) {
                        return NewsCard(result: cresult);
                      }).toList() ?? [ShimmerNewsCard(), ShimmerNewsCard(), ShimmerNewsCard()],
                    ),
                  ),
                             Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Worldwide",style: GoogleFonts.noticiaText(color: blacky,fontWeight: FontWeight.bold,fontSize: 22),),
             
       InkWell(
         onTap: () {
           Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewMore(category: "")
          ));
        },
        child: Text('view more',style: GoogleFonts.noticiaText(color: purply,fontSize: 18,fontWeight: FontWeight.w500),)),
    
  ],
),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: news_everywhere?.map((news_everywhere) {
                        return NewsCard(result: news_everywhere);
                      }).toList() ?? [ShimmerNewsCard(), ShimmerNewsCard(), ShimmerNewsCard()],
                    ),
                  ),
                
                ],
              ),
            ),],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 0.0:1.0  ,
        duration: Duration(milliseconds: 500),
        child: FloatingActionButton(
          backgroundColor: purply,
          onPressed: () {
           _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: Icon(CupertinoIcons.up_arrow),
        ),
      ),
    );
  }
}
DateTime dateTime = DateTime.now();
