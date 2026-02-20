import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/state/authState.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/customLoader.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/rippleButton.dart';
import 'package:flutter_twitter_clone/widgets/newWidget/title_text.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
    required this.loader,
    this.loginCallback,
  }) : super(key: key);
  final CustomLoader loader;
  final Function? loginCallback;
  void _googleLogin(context) {
    var state = Provider.of<AuthState>(context, listen: false);
    loader.showLoader(context);

    state.handleGoogleSignIn().then((status) {
      loader.hideLoader();

      final userEmail = state.user?.email?.toLowerCase() ?? '';
      // if (!userEmail.endsWith('@student.uol.edu.pk')) {
      //   Utility.customSnackBar(
      //       context, 'Only @student.uol.edu.pk emails are allowed to login.');
      //   state.isSignInWithGoogle = true;
      //   state.logoutCallback?.call(); // Optional: log out the invalid user
      //   return;
      // }

      if (state.user != null) {
        Navigator.pop(context);
        if (loginCallback != null) loginCallback!();
      } else {
        cprint('Unable to login', errorIn: '_googleLoginButton');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onPressed: () {
        _googleLogin(context);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0xffeeeeee),
              blurRadius: 15,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Wrap(
          children: <Widget>[
            Image.asset(
              'assets/images/google_logo.png',
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            const TitleText(
              'Continue with Google',
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
