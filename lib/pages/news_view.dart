import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/source_page.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                    
                  }, 
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(blacky!)
                  ),
                  child:Text(
                        widget.result.sourceId!.isNotEmpty == true
                            ? widget.result.sourceId!
                            : "Source unknown",  // Use the conditional operator to check for null or empty list
                        style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold,color: whitey),
                      ), ),
                   Padding(
                      padding: const EdgeInsets.only(left:28.0),
                      child: Text(
                        widget.result.category?.isNotEmpty == true
                                            ?'•'+ widget.result.category!.map((cat) => cat.toString().split('.').last).join(', ')
                                            : '', // Use the conditional operator to check for null or empty list
                        style: GoogleFonts.poppins(fontSize: 14,color: purply),
                      ),
                    )
                ],
              ),SizedBox(height: MediaQuery.of(context).size.height*0.03,),
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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: widget.result.imageUrl !=null  
                  ?NetworkImage("${widget.result.imageUrl}") 
                  : AssetImage("assets/images/news.jpg") as ImageProvider)
                ),
              ),Text("Description: ",style: GoogleFonts.noticiaText(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
               Text(
                widget.result.description == null ? "This article's description is not available":utf8.decode(widget.result.description.toString().codeUnits),
                style: GoogleFonts.noticiaText(color: Colors.black,fontSize: 16),
                overflow: TextOverflow.visible,
                maxLines:null 
                ,),Text("Content: ",style: GoogleFonts.noticiaText(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
               Text(
                widget.result.content == null 
                ?"This article's content is not available "
                :utf8.decode(widget.result.content.toString().codeUnits), 
                style: GoogleFonts.noticiaText(color: Colors.black,fontSize: 16),
                overflow: TextOverflow.visible,
                maxLines:null 
                ,),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                        launch(widget.result.link.toString());
                      },
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    width: MediaQuery.of(context).size.width*0.5,
                    decoration: BoxDecoration(
                      color: purply,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Center(
                      child: Text("Read from website",style: GoogleFonts.noticiaText(fontSize: 18,fontWeight: FontWeight.bold,color: whitey)),
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
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.1, // Adjust the width as needed
                child: FloatingActionButton(
                  backgroundColor: purply,
                  onPressed: () {
                    _scrollToTop();
                  },
                  child: Icon(CupertinoIcons.arrow_up_circle, color: whitey,),
                  
                  
                ),
              ),
            )
          : null,
          
    );
  }
}