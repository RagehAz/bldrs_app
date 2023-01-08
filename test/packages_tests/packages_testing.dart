import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bldrs_theme/bldrs_theme.dart' as bldrs_iconz;


void main() {
  // -----------------------------------------------------------------------------
  test('check bldrs_theme asset exists', () async {

    WidgetsFlutterBinding.ensureInitialized();

    const String _icon = bldrs_iconz.Iconz.play;
    final bool exists = await bldrs_iconz.Iconz.checkAssetExists(_icon);
    expect(exists, true);

    const String icon2 = 'lib/assets/icons/gi_bzzzzzz.jpg';
    final bool exists2 = await bldrs_iconz.Iconz.checkAssetExists(icon2);
    expect(exists2, false);

  });

  // -----------------------------------------------------------------------------
}
