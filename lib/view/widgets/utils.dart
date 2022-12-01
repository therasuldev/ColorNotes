import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:smallnotes/note.dart';

class ViewUtils {
  static bottomSheet({
    required BuildContext context,
    required String selectColor,
    required String changeColor,
    required Color pickerColor,
    required void Function(Color) changePickerColor,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const ShapeBorder(),
      backgroundColor: AppColors.brown200,
      builder: (context) {
        const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(selectColor, style: style),
              const SizedBox(height: 10),
              ColorPicker(
                  pickerColor: pickerColor, onColorChanged: changePickerColor),
              const SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }

  static selectTextColorSheet({
    required BuildContext context,
    required String textColor,
    required Color pickerColor,
    required void Function(Color) changePickerColor,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const ShapeBorder(),
      backgroundColor: AppColors.brown200,
      builder: (context) {
        const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(textColor, style: style),
              const SizedBox(height: 10),
              ColorPicker(
                  pickerColor: pickerColor, onColorChanged: changePickerColor),
              const SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }

  // showSnack shows easy-modifiable snack bar.
  static showSnack(
    BuildContext context, {
    required String msg,
    bool isFloating = false,
    required Color color,
    int sec = 4,
  }) async {
    final snack = SnackBar(
      content: Text(msg, style: TextStyle(color: AppColors.white)),
      duration: Duration(seconds: sec),
      margin: isFloating ? const EdgeInsets.all(8) : null,
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: isFloating
            ? BorderRadius.circular(8)
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
      ),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

class ShowAndEditItemCard extends BoxDecoration {
  ShowAndEditItemCard({int? color}) : super(color: Color(color ?? 0x00000000));
}

class SettingsCard extends BoxDecoration {
  SettingsCard()
      : super(
            color: AppColors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(10));
}

class SettingsDecor extends BoxDecoration {
  SettingsDecor({Color? color})
      : super(borderRadius: BorderRadius.circular(10), color: color);
}

class HistoryCardDecoration extends BoxDecoration {
  HistoryCardDecoration(BuildContext context)
      : super(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(12));
}

class ItemCard extends BoxDecoration {
  ItemCard({int? color, int? borderColor})
      : super(
            color: Color(color ?? 0x00000000),
            border: Border.all(color: Color(borderColor!), width: .5),
            borderRadius: BorderRadius.circular(7));
}

class TextAndTitleCard extends BoxDecoration {
  TextAndTitleCard({required BuildContext context})
      : super(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.black, width: .5));
}

class NumCard extends BoxDecoration {
  NumCard({required BuildContext context, required Color color})
      : super(
            color: Theme.of(context).cardTheme.color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(color: color, width: 2));
}

class DefaultDecor extends BoxDecoration {
  DefaultDecor()
      : super(
            color: AppColors.blueGrey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ));
}

class CatalogForItemCard extends BoxDecoration {
  CatalogForItemCard({required BuildContext context})
      : super(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor,
              spreadRadius: .5,
              blurRadius: 5,
              offset: const Offset(-10, 0),
            ),
            BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor,
              offset: const Offset(-5, 0),
            ),
          ],
        );
}

class ShapeBorder extends RoundedRectangleBorder {
  const ShapeBorder()
      : super(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)));
}

class NonBorderDecoration extends InputDecoration {
  NonBorderDecoration({required String hint, required BuildContext context})
      : super(
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintStyle: TextStyle(
              color: Theme.of(context).primaryTextTheme.bodyText1!.color),
        );
}

class GeneralButtonStyle extends ButtonStyle {
  GeneralButtonStyle({
    Color color = Colors.black,
    Color backgroundColor = Colors.transparent,
    double radius = 0,
    double stroke = 1.5,
    bool borderEnabled = true,
    Size size = const Size(0, 40),
  }) : super(
          overlayColor: MaterialStateProperty.all(color.withOpacity(.1)),
          fixedSize: MaterialStateProperty.all(size),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                side: borderEnabled
                    ? BorderSide(color: color, width: stroke)
                    : BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(radius))),
          ),
        );
}

class UnderlineBorderDecoration extends InputDecoration {
  final underlineInputBorder =
      UnderlineInputBorder(borderSide: BorderSide(color: AppColors.blue));
  UnderlineBorderDecoration()
      : super(
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.blue)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.blue)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.blue)),
            errorBorder: InputBorder.none,
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.blue)),
            focusedErrorBorder: InputBorder.none,
            hintStyle: TextStyle(color: AppColors.brownAccent));
}

class GenerateDialog extends AlertDialog {
  GenerateDialog({
    super.key,
    required BuildContext context,
    required String title,
    required String cancelTitle,
    required String actTitle,
    required Function() onAct,
    Color actColor = Colors.red,
  }) : super(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(title, maxLines: 2, style: const TextStyle(fontSize: 17)),
          actions: [
            TextButton(
              key: const Key('cancel.button'),
              child:
                  Text(cancelTitle, style: const TextStyle(color: Colors.blue)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              style: GeneralButtonStyle(color: actColor, borderEnabled: false),
              onPressed: onAct,
              child: Text(actTitle, style: const TextStyle(color: Colors.red)),
            )
          ],
        );
}
