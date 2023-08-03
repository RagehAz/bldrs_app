import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:fire/super_fire.dart';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  final String _code = Localizer.getCurrentLangCode();
  final String? _ldb = await Localizer.readLDBLangCode();
  blog('kos omak : $_code : $_ldb');

  await Dialogs.topNotice(verse: Verse.plain('kos omak : $_code : $_ldb'));

  // await BldrsNav.goToLogoScreenAndRemoveAllBelow(animatedLogoScreen: false);

}
