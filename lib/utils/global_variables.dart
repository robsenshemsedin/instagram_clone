import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/contriant_practice.dart';
import 'package:instagram_clone/screens/screens_export.dart';

const webDimention = 600;

const homeScreens = [
  FeedScreen(),
  ConstriantPractice(),
  AddPostScreen(),
  Center(
    child: Text('Favorite'),
  ),
  Center(
    child: Text('Person'),
  )
];
