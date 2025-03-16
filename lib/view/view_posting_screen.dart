import 'package:flutter/material.dart';
import 'package:house/model/posting_model.dart';

class ViewPostingScreen extends StatefulWidget {

  PostingModel? posting;
  ViewPostingScreen({super.key, this.posting});

  @override
  State<ViewPostingScreen> createState() => _ViewPostingScreenState();
}

class _ViewPostingScreenState extends State<ViewPostingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}