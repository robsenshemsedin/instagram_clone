import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimentions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayout(
      {super.key,
      required this.mobileScreenLayout,
      required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constriant) {
        if (constriant.maxWidth < webDimention) {
          return mobileScreenLayout;
        }
        return webScreenLayout;
      },
    );
  }
}
