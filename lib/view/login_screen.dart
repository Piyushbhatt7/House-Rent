import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house/global.dart';
import 'package:house/view/signup_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: ListView(
          children: [

            Image.asset("images/logo.png"),

            const Text(
              "hello friend, \nwelcome back",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 3,
                color: Colors.white,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                  key: _formKey,
                child: Column(

                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
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
                          if(!valueEmail!.contains("@"))
                            {
                              return "Please write valid email.";
                            }
                          return null;
                        },
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 21.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        controller: _passwordTextEditingController,
                        obscureText: true,
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
                      padding: const EdgeInsets.only(top: 26.0),
                      child: ElevatedButton(
                          onPressed: () async
                          {
                             if(_formKey.currentState!.validate())
                             {
                               await userViewModel.login(
                                _emailTextEditingController.text.trim(), 
                                _passwordTextEditingController.text.trim(),
                                );
                             }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 60,)
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              color: Colors.white
                            ),
                          )
                      ),
                    ),

                    TextButton(
                        onPressed: ()
                        {
                           Get.to(SignupScreen());
                        },
                        child: const Text(
                          "Don't have an account? Register here",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                          ),
                        )
                    ),

                    const SizedBox(
                      height: 60.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}