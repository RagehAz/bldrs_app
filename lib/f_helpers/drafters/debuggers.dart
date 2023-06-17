import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/foundation.dart';
/// --------------------------------------------------------------------------
Future<void> reportThis(String text) async {

    if (kDebugMode == true){
      await Dialogs.centerNotice(
        verse: Verse.plain('Debug Report'),
        body: Verse.plain(text),
        color: Colorz.red255,
      );
    }

}
/// --------------------------------------------------------------------------
