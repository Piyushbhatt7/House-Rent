import 'package:flutter/material.dart';
import 'package:house/model/app_constants.dart';

class SavedListingsScreen extends StatefulWidget {
  const SavedListingsScreen({super.key});

  @override
  State<SavedListingsScreen> createState() => _SavedListingsScreenState();
}

class _SavedListingsScreenState extends State<SavedListingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: AppConstants.currentUser.savedPostings!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 3 / 4,
          ), 
        itemBuilder: (context, index)
        {

        }
        ),
    );
  }
}