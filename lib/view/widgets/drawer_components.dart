// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smallnotes/gen/assets.gen.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/widgets/header.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteDrawer extends NoteStatefulWidget {
  NoteDrawer({Key? key}) : super(key: key);

  @override
  State<NoteDrawer> createState() => _NoteDrawerState();
}

class _NoteDrawerState extends NoteState<NoteDrawer> with NoteDrawerMixin {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            height: 90,
            width: 90,
            alignment: Alignment.center,
            child: Image.asset(Assets.img.notes.path),
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          ListTile(
            title: Text(note.fmt(context, 'drawer.1')),
            leading: Icon(PhosphorIcons.heartBold, color: AppColors.red),
            onTap: () => AppRoute.toFavorite(context),
          ),
          ListTile(
              title: Text(note.fmt(context, 'drawer.2')),
              leading: Icon(
                PhosphorIcons.shareNetwork,
                color: AppColors.blueGrey.withRed(5),
              ),
              onTap: () {} //_shareNoteApp(),
              ),
          ListTile(
            title: Text(note.fmt(context, 'drawer.3')),
            leading: Icon(PhosphorIcons.star, color: AppColors.darkYellow),
            onTap: () {}, //=> _rateNoteApp(),
          ),
          ListTile(
              title: Text(note.fmt(context, 'drawer.4')),
              leading: Icon(Icons.settings, color: AppColors.blueGrey),
              onTap: () => AppRoute.toSettings(context)),
          ListTile(
            title: Text(note.fmt(context, 'drawer.5')),
            leading: Icon(PhosphorIcons.infoBold, color: AppColors.grey),
            onTap: () => _noteAppInformation(context),
          ),
        ],
      ),
    );
  }
}

mixin NoteDrawerMixin on NoteState<NoteDrawer> {
  final Uri _urlTG = Uri.parse('https://t.me/+FdwYxaL9vos2NmYy');
  final Uri _urlINSTA = Uri.parse('https://www.instagram.com/flutter.uiux/');

  //_shareNoteApp() {}

  // _rateNoteApp() {
  //   final dialog = RatingDialog(
  //     title: const Text('Rate Us On App Store'),
  //     message: const Text('Select Number of Stars 1 - 5 to Rate This App'),
  //     image: const FlutterLogo(size: 60),
  //     submitButtonText: 'Submit',
  //     onCancelled: () => print('cancelled'),
  //     onSubmitted: (response) {
  //       print('rating: ${response.rating}, comment: ${response.comment}');
  //       if (response.rating < 3.0) {
  //       } else {
  //         StoreRedirect.redirect(androidAppId: 'com.example.my_note');
  //       }
  //     },
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (context) => dialog,
  //   );
  // }

  _noteAppInformation(context) {
    return showDialog(
      barrierColor: AppColors.black.withOpacity(.1),
      context: context,
      builder: (BuildContext context) {
        return ContactUsModelView(
          launchInstagram: _launchInstagram,
          launchTelegram: _launchTelegram,
        );
      },
    );
  }

  void _launchTelegram() async {
    if (!await launchUrl(_urlTG,
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch $_urlTG';
    }
  }

  void _launchInstagram() async {
    if (!await launchUrl(_urlINSTA,
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch $_urlINSTA';
    }
  }
}

class ContactUsModelView extends NoteStatelessWidget {
  ContactUsModelView({
    Key? key,
    this.launchTelegram,
    this.launchInstagram,
  }) : super(key: key);

  final Function()? launchTelegram;
  final Function()? launchInstagram;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          height: 150,
          width: 100,
          color: AppColors.greyAccent.withOpacity(.5),
          child: _contactCardComponents(context),
        ),
      ),
    );
  }

  Widget _contactCardComponents(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          note.fmt(context, 'app.pres'),
          style:
              GoogleFonts.rubikMoonrocks(fontSize: 16, color: AppColors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Telegram(onTap: launchTelegram),
            Instagram(onTap: launchInstagram)
          ],
        )
      ],
    );
  }
}
