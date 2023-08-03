import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  blog('a7a');

  // final String _code = Localizer.getCurrentLangCode();
  // final String? _ldb = await Localizer.readLDBLangCode();
  // blog('kos omak : $_code : $_ldb');
  //
  // await Dialogs.topNotice(verse: Verse.plain('kos omak : $_code : $_ldb'));

  await Dialogs.confirmProceed();

  // await BldrsNav.goToLogoScreenAndRemoveAllBelow(animatedLogoScreen: false);

}
