import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/resources_export.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:
        Consumer<UserProvider>(builder: (context, userProvider, complexChild) {
      return Text(userProvider.getUser.username);
    })));
  }
}
