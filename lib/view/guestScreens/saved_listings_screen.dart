import 'package:flutter/material.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/view/widgets/posting_grid_tile_ui.dart';

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
          PostingModel currentPosting = AppConstants.currentUser.savedPostings![index];

          return Stack(
            children: [

              InkResponse(
                enableFeedback: true,
                child: PostingGridTileUi(
                  posting: currentPosting,
                ),
              )
            ],
          );
        }
        ),
    );
  }
}