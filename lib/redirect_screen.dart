import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/drawing/expander.dart';
import 'package:basics/helpers/rest/rest.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class RedirectScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const RedirectScreen({
    required this.path,
    required this.arg,
    super.key,
  });
  // --------------------
  final Map<String, String> arg;
  final String? path;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        id: 'Redirect',
        translate: false,
      ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain(''),
        ),

      ],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            BldrsBox(
              height: 40,
              verseScaleFactor: 0.7,
              verse: Verse.plain(path),
              secondLine: Verse.plain(arg.toString()),
              color: Colorz.bloodTest,
              verseMaxLines: 999,
              maxWidth: MediaQuery.of(context).size.width,
            ),

            BldrsBox(
              height: 40,
              verseScaleFactor: 0.7,
              verse: Verse.plain('Request'),
              color: Colorz.bloodTest,
              onTap: () async {
                final uri = Uri(
                  scheme: 'https',
                  host: 'graph.facebook.com',
                  path: 'v16.0/17841447816479749',
                  queryParameters: <String, String>{
                    'fields': '''
business_discovery.username(modulorstudio_eg) {
profile_picture_url,
ig_id,
followers_count,
name,
website,
media {
  media_url,children{media_url}
 }
}''',
                    'access_token': arg['access_token']!,
                  },
                );
                final response = await Rest.get(
                    rawLink: uri.toString(), invoker: 'graph test');

                Rest.blogResponse(response: response);
              },
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
