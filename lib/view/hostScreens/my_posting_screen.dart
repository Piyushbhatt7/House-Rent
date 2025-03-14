import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/view/hostScreens/create_posting_screens.dart';
import 'package:house/view/widgets/posting_list_tile.dart';

class MyPostingScreen extends StatefulWidget {
  const MyPostingScreen({super.key});

  @override
  State<MyPostingScreen> createState() => _MyPostingScreenState();
}

class _MyPostingScreenState extends State<MyPostingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ListView.builder(
        itemCount: AppConstants.currentUser.myPostings!.length + 1,
        itemBuilder: (context, index)
        {
          return  Padding(
        padding: const EdgeInsets.fromLTRB(26.0, 0, 26, 26),
        child: InkResponse(
          onTap: ()
           {
             Get.to(CreatePostingScreens(
               posting: (index == AppConstants.currentUser.myPostings!.length) ? null : AppConstants.currentUser.myPostings![index],
             ));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.2,
              ),
            ),
            
            child: PostingListTile(),     
          ),
        ),
      
      );

        }
        ),
    );
  }
}