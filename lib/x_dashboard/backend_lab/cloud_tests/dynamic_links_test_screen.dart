import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
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

  @override
  Widget build(BuildContext context) {

    return CenteredListLayout(
        titleVerse: Verse.plain('Dynamic Links'),
        columnChildren: <Widget>[

          WideButton(
            verse: Verse.plain('Initialize dynamic Links'),
            onTap: () async {

              await DynamicLinks.initDynamicLinks(context);

            },
          ),

          WideButton(
            verse: Verse.plain('Create dynamic Link'),
            onTap: () async {

              final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);
              final String flyerID = _user.savedFlyers.all.first;

              final Uri _uri = await DynamicLinks.createDynamicLink(
                title: 'Fuckk you bitch',
                description: 'eh dah el gamal da',
                urlOrPath: Storage.generateFlyerPosterPath(flyerID),
              );

              DynamicLinks.blogURI(
                uri: _uri,
              );

              await Keyboard.copyToClipboard(context: context, copy: _uri.path);

            },
          ),

        ],
    );

  }
}
