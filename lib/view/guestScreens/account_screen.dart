import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:house/global.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/view/guest_home_screen.dart';
import 'package:house/view/host_home_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  String _hostingTitle = 'Show my Dashboard'; // 13:48 - 7

  modifyHostingMode() async
  {
    if(AppConstants.currentUser.isHost!)
    {
      if(AppConstants.currentUser.isCurrentlyHosting!)
      {
         AppConstants.currentUser.isCurrentlyHosting = false;

         Get.to(GuestHomeScreen());
      }
      else{
        
        AppConstants.currentUser.isCurrentlyHosting = false;

        Get.to(HostHomeScreen());
      }
    
    }
    else{
        
      await  userViewModel.becomeHost(FirebaseAuth.instance.currentUser!.uid);

      AppConstants.currentUser.isCurrentlyHosting = true;

      Get.to(HostHomeScreen());
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
     if(AppConstants.currentUser.isHost!)
    {
      if(AppConstants.currentUser.isCurrentlyHosting!)
      {
         _hostingTitle = 'Show my Guest Dashboard';
      }
      else{
        
         _hostingTitle = 'Show my Host Dashboard';
      }
    
    }
    else{
        
        _hostingTitle = 'Become a Host';
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 50, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
  
          // user info   

            Padding(padding:const EdgeInsets.only(bottom: 30.0),
            child: Center(
              child: Column(
                children: [

                  // image
                  
                  MaterialButton(
                     onPressed: () {},
                
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: MediaQuery.of(context).size.width / 4.5,

                      child: CircleAvatar(
                        backgroundImage: AppConstants.currentUser.displayImage
                        ??  NetworkImage('https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'),
                         radius: MediaQuery.of(context).size.width / 4.6,
                      ),
                    ),
                   ),

                   const SizedBox(height: 10.0,),

                   // name and email

                   Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppConstants.currentUser.getFullNameofUser(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      
                      Text(
                        AppConstants.currentUser.email.toString(),
                        style: const TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                   )
                ],
              ),
            ),
             ),
            
            // button

            ListView(
              shrinkWrap: true,
              children: [

               // Personal information button

                Container(
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
               child: MaterialButton(
                height: MediaQuery.of(context).size.height / 9.1,
                onPressed: ()
               {

               },
               child: ListTile(
                contentPadding: const EdgeInsets.all(0.0),
                leading: Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 18.5,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: Icon(
                  size: 34,
                  Icons.person_2_sharp,
                ),
               ),
               ),
                ),
             
               // change hosting button

               Container(
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
               child: MaterialButton(
                height: MediaQuery.of(context).size.height / 9.1,
                onPressed: ()
               {
                  modifyHostingMode();
               },
               child: ListTile(
                contentPadding: const EdgeInsets.all(0.0),
                leading: Text(
                  _hostingTitle,
                  style: const TextStyle(
                    fontSize: 18.5,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: Icon(
                  size: 34,
                  Icons.hotel_rounded,
                ),
               ),
               ),
                )
             
             
             
             
              ],
            )
        
          ],
        ),
        ),
    );
  }
}