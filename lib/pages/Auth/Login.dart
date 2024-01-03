import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/utils.dart';
import 'package:news_app/widgets/color.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible=true;
  TextEditingController login=TextEditingController();
  TextEditingController password=TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        
        child: Form(
          key:formKey,
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
                    ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor:purply,
                        elevation:0,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      onPressed: signIn, child: Center(
                        child: Text("Login",style: GoogleFonts.poppins(color: whitey,fontSize: 16,fontWeight: FontWeight.bold))
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Row(
                        children: [
                          Text("Don't have an account yet?  ",style: GoogleFonts.poppins(
                            color: blacky,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                          ),),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, "/register");
                            },
                            child: Text("click here to register!",style: GoogleFonts.poppins(
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
 Future signIn() async {
  final isValid = formKey.currentState!.validate();
  if (!isValid) return;

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: login.text.trim(),
      password: password.text.trim(),
    );
    Navigator.pushReplacementNamed(context, '/home');
  } on FirebaseAuthException catch (e) {
    print('Sign-in error: $e');
    Utils.showSnackBar(e.message);
  }
}
}

