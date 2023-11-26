// import 'package:instagram_clone/responsive/responsive_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/responsive_export.dart';
import 'package:instagram_clone/screens/screens_export.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const InstagramClone());
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: primaryColor)),
        home: ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  // If the data is not null then the user is logged in aready.
                  if (snapshot.hasData) {
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  // If the user data is null then the user is not logged in.
                  else {
                    return const LoginScreen();
                  }
                }
                return const Center(child: CircularProgressIndicator());
              })),
        ));
  }
}
