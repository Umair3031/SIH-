import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bliss/auth_services/firebase.dart';



class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  // for suffix icon of eye in password textform field
  void _togglePasswordView(){
    setState(() {
      _isHidden = ! _isHidden;
    });
  }
  
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final confrimpasswordController = TextEditingController();


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
            Text(
              'Register',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 35, 
              ),
            ),

            SizedBox(height: 30),


            Form(
              child: Column(
                children: [

                  // First name 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: TextFormField(
                      controller: firstnameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'First name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),

                  // Last name
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: TextFormField(
                      controller: lastnameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Last name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),

                  // Email box

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: TextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value){

                      },

                      validator : (value){
                        return value!.isEmpty ? 'Please enter email' : null;
                      }
                    ),
                  ),

                  // password
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key_rounded),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value){

                      },

                      validator : (value){
                        return value!.isEmpty ? 'Please enter Password' : null;
                      }
                    ),
                  ),

                  // confirm passsword

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: TextFormField(
                      controller: confrimpasswordController,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        prefixIcon: Icon(Icons.vpn_key_rounded),
                        border: OutlineInputBorder(),
                        suffix: InkWell(onTap: _togglePasswordView,
                        child: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),)
                      ),
                      onChanged: (String value){

                      },

                      validator : (value){
                        return value!.isEmpty ? 'Please re-enter Password' : null;
                      }
                    ),
                  ),

                  SizedBox(height: 35),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () async {

                        // firebase authentication and cloud firestone used 
                        try{
                          await Firebase.initializeApp();
                          UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordController.text
                          );
                          User? updateUser = FirebaseAuth.instance.currentUser;
                          // ignore: deprecated_member_use
                          updateUser?.updateProfile(displayName: firstnameController.text);
                        }on FirebaseAuthException catch (e){
                        }

                        // firebase end 

                        Navigator.pushNamed(context, "/homepage" );
                      },
                      child: Text('Sign up'),
                      color: Colors.teal,
                      textColor: Colors.white,
                    ),
                  )
                ],)
              )
          ],
        ),
      ),
    );
    
  }
}