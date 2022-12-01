import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

import '../../gen/assets.gen.dart';

typedef HeaderCallBack = void Function()?;

class Telegram extends NoteStatelessWidget {
  Telegram({Key? key, this.onTap}) : super(key: key);
  final HeaderCallBack onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(Assets.svg.telegram, height: 50, width: 50),
    );
  }
}

class Instagram extends NoteStatelessWidget {
  Instagram({Key? key, this.onTap}) : super(key: key);
  final HeaderCallBack onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(Assets.svg.instagram, height: 50, width: 50),
    );
  }
}
