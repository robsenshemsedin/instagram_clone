import 'package:instagram_clone/responsive/responsive_export.dart';
import 'package:instagram_clone/screens/screens_export.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: const LoginScreen()
        // const ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // )
        );
  }
}
