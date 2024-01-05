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
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentCountryCode = "Loading...";
  String clickedBtn="";
  List<Result>? results;
  bool isTapped = false;
  String selectedCategory = "Top";
  List<String> categories = ["Top","World","Tourism","Politics", "Technology", "Sports", "Entertainment", "Health", "Business","Science","Environment","Food" ];
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  bool isClicked=true;

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
  


bool isFetchingCountryCode = false;

Future<void> initCurrentCountryCode() async {
  setState(() {
    isFetchingCountryCode = true;
  });

  try {
    String code = await NewsServices().getCurrentCountryCode();
    // Fetch news based on the selected category
    List<Result> newsResults = await NewsServices().getNewsByCategory(code, selectedCategory);

    // Update UI with the current country code and fetched news
    setState(() {
      currentCountryCode = code.toLowerCase();
      results = newsResults;
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
        centerTitle: true,
        title: Icon(CupertinoIcons.home,color: purply,size: 35,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: ()
            {
              Navigator.pushNamed(context, "/source");
            }, icon: Icon(CupertinoIcons.news_solid,color: purply,size: 32,)
                          ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController, 
        child: Column(
          children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: GestureDetector(
                         onTap: () async {
                        setState(() {
                          selectedCategory = category;
                        });
                        if (category == "All") {
                          selectedCategory = "Top";
                        }
                        await initCurrentCountryCode();
                      },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedCategory == category ? blacky : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                  color: selectedCategory == category ? Colors.grey[300] : Colors.grey[500],
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trending ",style: GoogleFonts.poppins(color: blacky,fontWeight: FontWeight.bold,fontSize: 22),),
                   InkWell(
                    onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewMore(category: selectedCategory.toString())
            ));
                    },
                    child: Text('view more',style: GoogleFonts.poppins(color: purply,fontSize: 18,fontWeight: FontWeight.w500),)),
                
              ],
            ),
          ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: isFetchingCountryCode
                  ? Padding(
                    padding:const  EdgeInsets.only(top:250.0),
                    child: Lottie.asset(
                       "assets/animations/newsPaper.json",
                    ),
                  ) 
                  : Column(
                      children: results?.map((result) {
                        return NewsCard(result: result);
                      }).toList() ??
                          [ShimmerNewsCard(), ShimmerNewsCard(), ShimmerNewsCard(),ShimmerNewsCard(), ShimmerNewsCard(),ShimmerNewsCard(), ShimmerNewsCard(),],
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
          child: Icon(CupertinoIcons.up_arrow,color: whitey,),
        ),
      ),
    );
  }
}
DateTime dateTime = DateTime.now();
