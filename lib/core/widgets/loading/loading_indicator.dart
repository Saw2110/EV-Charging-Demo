import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool shouldUseScaffold;
  final Color? scaffoldColor;
  final Color? progressColor;
  final bool isLinear;

  const LoadingIndicator({
    super.key,
    this.shouldUseScaffold = false,
    this.scaffoldColor,
    this.progressColor,
    this.isLinear = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child = Center(
      child: isLinear
          ? const LinearProgressIndicator()
          : const CircularProgressIndicator.adaptive(),
    );
    if (shouldUseScaffold) {
      return Scaffold(
        backgroundColor: scaffoldColor,
        body: child,
      );
    }
    return child;
  }
}
