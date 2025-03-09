import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:house/global.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();
  TextEditingController _firstNameTextEditingController = TextEditingController();
  TextEditingController _lastNameTextEditingController = TextEditingController();
  TextEditingController _cityTextEditingController = TextEditingController();
  TextEditingController _countryTextEditingController = TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? imageFileofUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.amberAccent
                ],
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(1, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: const Text(
          'Create New Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent.shade200,
                Colors.amberAccent
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            )
        ),
        child: ListView(

          children: [

            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25,),
              child: Image.asset(
                "images/signup.png",
                width: 240,
              ),
            ),

            const Text(
              "Tell us about you",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent
              ),
              textAlign: TextAlign.center,
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Email",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          controller: _emailTextEditingController,
                          validator: (valueEmail)
                          {
                            if(valueEmail!.isEmpty)
                            {
                              return "Please write valid email.";
                            }
                            return null;
                          },
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Password",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          controller: _passwordTextEditingController,
                          validator: (valuePassword)
                          {
                            if(valuePassword!.length < 5)
                            {
                              return "Password must be at least more then 5 characters.";
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "First Name",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          controller: _firstNameTextEditingController,
                          validator: (valueFName)
                          {
                            if(valueFName!.isEmpty)
                            {
                              return "Please write your first name.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Last Name",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          controller: _lastNameTextEditingController,
                          validator: (valueLName)
                          {
                            if(valueLName!.isEmpty)
                            {
                              return "Please write your last name.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "City",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          controller: _cityTextEditingController,
                          validator: (valueCity)
                          {
                            if(valueCity!.isEmpty)
                            {
                              return "Please enter your city name.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Country",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          controller: _countryTextEditingController,
                          validator: (valueCountry)
                          {
                            if(valueCountry!.isEmpty)
                            {
                              return "Please write your county name.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Bio",
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          maxLines: 4,
                          controller: _bioTextEditingController,
                          validator: (valueBio)
                          {
                            if(valueBio!.isEmpty)
                            {
                              return "Please write your Bio.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ],
                  )
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: MaterialButton(
                  onPressed: (){

              },
              child: imageFileofUser == null
                  ? const Icon(Icons.add_a_photo_outlined)
                  : CircleAvatar(
                backgroundColor: Colors.pink,
                radius: MediaQuery.of(context).size.width / 5.0,
                child: CircleAvatar(
                  backgroundImage: FileImage(imageFileofUser!),
                  radius: MediaQuery.of(context).size.width / 5.0,
                ),
              ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 44.0, right: 60.0, left: 60.0),
              child: ElevatedButton(
                  onPressed: ()
                  {
                      if(!_formKey.currentState!.validate() || imageFileofUser == null)
                      {
                        Get.snackbar("Field Missing", "Please choose image and fill out complete sign up form");
                        return;
                      }

                      if(_emailTextEditingController.text.isEmpty && _passwordTextEditingController.text.isEmpty)
                      {
                         Get.snackbar("Field Missing", "Please fill out complete sign up form");
                         return;
                      }
                      userViewModel.signUp(
                        _emailTextEditingController.text.trim(),
                        _passwordTextEditingController.text.trim(),
                        _firstNameTextEditingController.text.trim(),
                        _lastNameTextEditingController.text.trim(),
                        _cityTextEditingController.text.trim(),
                        _countryTextEditingController.text.trim(),
                        _bioTextEditingController.text.trim(),
                        imageFileofUser

                      );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,

                  ),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.white
                    ),
                  )
              ),
            ),

            const SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
    );
  }
}