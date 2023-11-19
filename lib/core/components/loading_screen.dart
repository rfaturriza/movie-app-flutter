import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_xsis/core/utils/extension/context_ext.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(
            context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
