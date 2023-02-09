import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class DynamicLinksTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DynamicLinksTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<DynamicLinksTestScreen> createState() => _DynamicLinksTestScreenState();
/// --------------------------------------------------------------------------
}

class _DynamicLinksTestScreenState extends State<DynamicLinksTestScreen> {

  @override
  void initState() {
    super.initState();

  }

  String _flyerURLLink = 'www.google.com';
  String _bzURLLink = 'www.apple.com';
  String _userURLLink = 'www.facebook.com';

  @override
  Widget build(BuildContext context) {

    return FloatingLayout(
        titleVerse: Verse.plain('Dynamic Links'),
        columnChildren: <Widget>[

          WideButton(
            verse: Verse.plain('Initialize dynamic Links'),
            onTap: () async {

              await DynamicLinks.initDynamicLinks(context);

            },
          ),

          const DotSeparator(),

          /// CREATE FLYER DYNAMIC LINK
          WideButton(
            verse: Verse.plain('FLYER : FlyerShareLink.generateFlyerLink'),
            onTap: () async {

              final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);
              final String _flyerID = _user.savedFlyers.all.first;

              final String _flyerURL = await BldrsShareLink.generateFlyerLink(
                context: context,
                flyerID: _flyerID,
              );

              await Keyboard.copyToClipboard(context: context, copy: _flyerURL);

              setState(() {
                _flyerURLLink = _flyerURL;
              });

            },
          ),

          /// GENERATE FLYER DYNAMIC LINK
          SuperVerse(
            verse: Verse.plain(_flyerURLLink),
            labelColor: Colorz.bloodTest,
            onTap: () async {
              await Launcher.launchURL(_flyerURLLink);
            }
          ),

          const DotSeparator(),

          /// CREATE BZ DYNAMIC LINK
          WideButton(
            verse: Verse.plain('BZ : FlyerShareLink.generateBzLink'),
            onTap: () async {

              final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);
              final String _bzID = _user.myBzzIDs.first;

              final String _bzURL = await BldrsShareLink.generateBzLink(
                context: context,
                bzID: _bzID,
              );

              await Keyboard.copyToClipboard(context: context, copy: _bzURL);

              setState(() {
                _bzURLLink = _bzURL;
              });

            },
          ),

          /// GENERATE BZ DYNAMIC LINK
          SuperVerse(
              verse: Verse.plain(_bzURLLink),
              labelColor: Colorz.bloodTest,
              onTap: () async {
                await Launcher.launchURL(_bzURLLink);
              }
          ),

          const DotSeparator(),

          /// CREATE USER DYNAMIC LINK
          WideButton(
            verse: Verse.plain('USER : FlyerShareLink.generateFlyerLink'),
            onTap: () async {

              final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);

              final String _userURL = await BldrsShareLink.generateUserLink(
                context: context,
                userID: _user.id,
              );

              await Keyboard.copyToClipboard(context: context, copy: _userURL);

              setState(() {
                _userURLLink = _userURL;
              });

            },
          ),

          /// GENERATE USER DYNAMIC LINK
          SuperVerse(
              verse: Verse.plain(_userURLLink),
              labelColor: Colorz.bloodTest,
              onTap: () async {
                await Launcher.launchURL(_userURLLink);
              }
          ),

          const DotSeparator(),

        ],
    );

  }
}
