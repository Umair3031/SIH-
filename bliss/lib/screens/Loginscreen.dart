import 'package:bliss/screens/homepage.dart';
import 'package:bliss/screens/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  // for suffix icon of eye in password textform field
  void _togglePasswordView(){
    setState(() {
      _isHidden = ! _isHidden;
    });
  }
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();

  bool _isHidden = true;

  @override
  void dispose(){
    emailcontroller.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          // Command to add bg image
          // BgImage(),   (save th eeimage in pubspec.yaml in assets or build.gradle assets)
            Text(
              'Login',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 35, 
              ),
            ),

            SizedBox(height: 30),


            Form(
              child: Column(
                children: [

                  // email

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    child: TextFormField(
                      controller: emailcontroller,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value){

                      },

                      validator : (value){
                        if (value!.isEmpty){
                          return ("'Please enter email'");
                        }
                        if (!RegExp(
                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                          .hasMatch(value)){
                            return ("Please enter a valid email");
                          }
                          return null;
                      }
                    ),
                  ),

                  // password
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    child: TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key_rounded),
                        border: OutlineInputBorder(),
                        suffix: InkWell(onTap: _togglePasswordView,
                        child: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),)
                      ),
                      onChanged: (String value){

                      },

                      validator : (value){
                        return value!.isEmpty ? 'Please enter Password' : null;
                      }
                    ),
                  ),

                  SizedBox(height: 35),

                  // sign in button

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: signIn,
                      child: Text('Sign in'),
                      color: Colors.teal,
                      textColor: Colors.white,
                    ),
                  ),

                  // sign up link

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Register as new user."),
                      

                      //  linking the link to sign up page


                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context) => Signupscreen()));
                        },
                        child: Text('SignUp',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),),
                      )
                    ],)
                ],)
              )
          ],
        ),
      ),
    );
    
  }  

  Future signIn() async {
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailcontroller.text.trim(),
       password: passwordController.text.trim(),
       
    );
    }on FirebaseAuthException catch (e) {
      print(e);
    }
    print("signin succesful");
    Navigator.push(
      context,MaterialPageRoute(builder: (context) => HomePage()));
  }
}