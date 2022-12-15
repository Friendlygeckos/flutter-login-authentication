import 'package:firebase_auth/firebase_auth.dart';

class GitHubAuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  // Native version - need to pass the buildcontext to the repo
  // Future<void> signInWithGitHub() async {
  //   final GitHubSignIn gitHubSignIn = GitHubSignIn(
  //     clientId: 'TODO',
  //     clientSecret: 'TODO',
  //     redirectUrl: 'TODO',
  //   );

  //   final gitHubSignInResult = await gitHubSignIn.signIn(context);

  //   final gitHubAuthCredential =
  //       GithubAuthProvider.credential(gitHubSignInResult.token!);

  //   await _firebaseAuth.signInWithCredential(gitHubAuthCredential);
  // }

  // Web version
  Future<void> signInWithGitHub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();

    await _firebaseAuth.signInWithPopup(githubAuthProvider);
  }

}
