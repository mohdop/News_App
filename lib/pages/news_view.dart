import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/widgets/color.dart';

class NewsDetails extends StatefulWidget {
  final Result result;
  
  const NewsDetails({super.key,required this.result});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  
  bool showFab = false;
  ScrollController _scrollController = ScrollController();
  Timer? _fabTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        showFab = _scrollController.position.pixels > 100; // Adjust the threshold as needed
        _resetTimer();
      });
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
  }
  void _resetTimer() {
    if (_fabTimer != null && _fabTimer!.isActive) {
      _fabTimer!.cancel();
    }

    _fabTimer = Timer(Duration(seconds: 3), () {
      setState(() {
        showFab = false;
      });
    });
  }
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: whitey,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.09,left: 12,right: 12),
          child: Column(

            children: [
              Row(
                children: [
                  Text(
                        widget.result?.sourceId!.isNotEmpty == true
                            ? widget.result!.sourceId!
                            : "Source unknown",  // Use the conditional operator to check for null or empty list
                        style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold),
                      ), Padding(
                      padding: const EdgeInsets.only(left:28.0),
                      child: Text(
                        widget.result.category?.isNotEmpty == true
                                            ?'•'+ widget.result.category!.map((cat) => cat.toString().split('.').last).join(', ')
                                            : '', // Use the conditional operator to check for null or empty list
                        style: GoogleFonts.poppins(fontSize: 14,),
                      ),
                    )
                ],
              ),
              Text(
                utf8.decode(widget.result.title.toString().codeUnits),
                style: GoogleFonts.noticiaText(color: blacky,fontWeight: FontWeight.bold,fontSize: 18,),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 225,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(image: widget.result.imageUrl !=null  
                  ?NetworkImage("${widget.result.imageUrl}") 
                  : AssetImage("assets/images/news.jpg") as ImageProvider)
                ),
              ),Text("Description: ",style: GoogleFonts.noticiaText(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
               Text(
                utf8.decode(widget.result.description.toString().codeUnits),
                style: GoogleFonts.noticiaText(color: Colors.black,fontSize: 16),
                overflow: TextOverflow.visible,
                maxLines:null 
                ,),Text("Content: ",style: GoogleFonts.noticiaText(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
               Text(
                utf8.decode(widget.result.content.toString().codeUnits),
                style: GoogleFonts.noticiaText(color: Colors.black,fontSize: 16),
                overflow: TextOverflow.visible,
                maxLines:null 
                ,),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Expanded(
                  child: GestureDetector(
                    onTap: () {
                          launch(widget.result.link.toString());
                        },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: purply,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Center(
                        child: Text("Go to website",style: GoogleFonts.noticiaText(fontSize: 18,fontWeight: FontWeight.bold,color: whitey)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,)

            ],
          ),
        ),
      ),
       floatingActionButton: showFab
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200, // Adjust the width as needed
                child: FloatingActionButton.extended(
                  backgroundColor: purply,
                  onPressed: () {
                    _scrollToTop();
                  },
                  icon: Icon(CupertinoIcons.arrow_up_circle, color: whitey,),
                  label: Text("Go Back Up", style: TextStyle(color: whitey)),
                ),
              ),
            )
          : null,
          
    );
  }
}