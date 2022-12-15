import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_authentication/bloc/auth_bloc.dart';
import 'package:flutter_login_authentication/repository/repository.dart';
import 'package:flutter_login_authentication/views/dashboard_page.dart';
import 'package:flutter_login_authentication/views/sign_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBer5ZVHDt4WgY4vL8ZOjG-KDtVntRRYiw",
    appId: "1:732331152451:web:38cf89da8d470d5290b0f6",
    messagingSenderId: "732331152451",
    projectId: "flutter-sign-in-options",
    authDomain: "flutter-sign-in-options.firebaseapp.com",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => GoogleAuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => FacebookAuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => TwitterAuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => GitHubAuthRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<GoogleAuthRepository>(context),
          facebookAuthRepository:
              RepositoryProvider.of<FacebookAuthRepository>(context),
          twitterAuthRepository:
              RepositoryProvider.of<TwitterAuthRepository>(context),
          gitHubAuthRepository:
              RepositoryProvider.of<GitHubAuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return const Dashboard();
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return const SignIn();
              }),
        ),
      ),
    );
  }
}
