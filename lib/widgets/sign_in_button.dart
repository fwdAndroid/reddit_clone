import 'package:flutter/material.dart';
import 'package:reddit_clone/widgets/theme.dart';

import '../utils/constant.dart';

class SignInButton extends StatelessWidget {
  final bool isFromLogin;
  const SignInButton({Key? key, this.isFromLogin = true}) : super(key: key);

  // void signInWithGoogle(BuildContext context, WidgetRef ref) {
  //   ref.read(authControllerProvider.notifier).signInWithGoogle(context, isFromLogin);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          Constants.googlePath,
          width: 35,
        ),
        label: const Text(
          'Continue with Google',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          primary: Pallete.greyColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
