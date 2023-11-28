import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/resources_export.dart';
import 'package:instagram_clone/utils/utils_export.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _selectedIndex = 0;

  late final pageController = PageController(initialPage: _selectedIndex);
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreens,
      ),
      // body: Center(child: Consumer<UserProvider>(
      //     builder: (context, userProvider, complexChild) {
      //   return Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const IconButton(
      //         onPressed: AuthMethods.signoutUser,
      //         icon: Icon(Icons.logout),
      //       ),
      //       Text(userProvider.getUser.username)
      //     ],
      //   );
      // })),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: changeSelectedIndex,
      ),
    );
  }

  changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });

    pageController.jumpToPage(_selectedIndex);
  }
}
