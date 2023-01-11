import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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

  String _url = 'www.google.com';

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

          WideButton(
            verse: Verse.plain('FlyerShareLink.generate'),
            onTap: () async {

              final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);
              final String _flyerID = _user.savedFlyers.all.first;

              final String _flyerURL = await FlyerShareLink.generate(
                context: context,
                flyerID: _flyerID,
              );

              await Keyboard.copyToClipboard(context: context, copy: _flyerURL);

              setState(() {
                _url = _flyerURL;
              });

            },
          ),

          SuperVerse(
            verse: Verse.plain(_url),
            labelColor: Colorz.bloodTest,
            onTap: () async {
              await Launcher.launchURL(_url);
            }
          ),

        ],
    );

  }
}
