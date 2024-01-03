import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/utils.dart';
import 'package:news_app/widgets/color.dart';
import 'package:country_picker/country_picker.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController login=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController password=TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isVisible=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.3,
            right: MediaQuery.of(context).size.height*0.02,
            left: MediaQuery.of(context).size.height*0.02
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                   
                    //  TextFormField(
                    //   controller: name,
                    //   decoration: InputDecoration(
                    //     labelText: "Enter your full name ",
                    //     labelStyle: GoogleFonts.poppins(color: blacky),
                    //     prefixIcon: Icon(CupertinoIcons.profile_circled),
                    //     prefixIconColor: purply,
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color:purply!,
                    //       ),
                    //     borderRadius: BorderRadius.circular(12)
                    //     )
                    //   ),
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    TextFormField(
                      controller: login,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Enter your mail",
                        labelStyle: GoogleFonts.poppins(color: blacky),
                        prefixIcon: Icon(CupertinoIcons.mail),
                        prefixIconColor: purply,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:purply!,
                          ),
                        borderRadius: BorderRadius.circular(12)
                        )
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    TextFormField(
                      controller: password,
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Enter your password",
                        labelStyle: GoogleFonts.poppins(color: blacky),
                        prefixIcon: Icon(CupertinoIcons.padlock, color: purply),
                        suffixIcon: buildPasswordToggleIcon(),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: purply!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    TextFormField(
                      obscureText: isVisible,
                      controller: confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Confirm your password",
                        labelStyle: GoogleFonts.poppins(color: blacky),
                        prefixIcon: Icon(CupertinoIcons.padlock, color: purply),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: purply!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != password.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                    ),SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor:purply,
                        elevation:0,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      onPressed:signUp, 
                      child: Center(
                       child: Text("Sign up",style: GoogleFonts.poppins(color: whitey,fontSize: 16,fontWeight: FontWeight.bold))
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Row(
                        children: [
                          Text("Already have an account?  ",style: GoogleFonts.poppins(
                            color: blacky,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                          ),),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, "/login");
                            },
                            child: Text("click here to login!",style: GoogleFonts.poppins(
                              color: purply,
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                          
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
   Widget buildPasswordToggleIcon() {
  return IconButton(
    color: blacky,
    onPressed: () {
      setState(() {
        isVisible = !isVisible;
      });
    },
    icon: isVisible
        ? Icon(CupertinoIcons.eye, color: blacky)
        : Icon(CupertinoIcons.eye_slash, color: blacky),
  );
  
}

 Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return; // Check if form is not valid, then return early

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: login.text.trim(),
        password: password.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to the Notes page
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
