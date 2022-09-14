import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_db/fire/methods/dynamic_links.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
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

              final Uri _uri = await DynamicLinks.createDynamicLink();

              DynamicLinks.blogURI(
                uri: _uri,
              );

            },
          ),

        ],
    );

  }
}
