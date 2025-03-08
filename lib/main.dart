import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house/view/splashscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://kgyywbichyoiqopyxpgb.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtneXl3YmljaHlvaXFvcHl4cGdiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE0MzI2NjQsImV4cCI6MjA1NzAwODY2NH0.X5mtQTxEEf8hOJzYLVYa5mJWqExhCXgh1Vzfcqy8f0s';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
 // await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}


