import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../note.dart';

class BallSpinFadeLoader extends NoteStatelessWidget {
  BallSpinFadeLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [
            AppColors.blueGrey,
            AppColors.red,
            AppColors.purple,
            AppColors.green,
            AppColors.orange,
            AppColors.blue,
          ],
          strokeWidth: 2,
          backgroundColor: AppColors.transparent,
          pathBackgroundColor: AppColors.black),
    );
  }
}
