import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/nav_bar_controller.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class MyBzzSelectorScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzzSelectorScreen({
    @required this.bzzModels,
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<BzModel> bzzModels;
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey('my_bzz_selector_screen'),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      pageTitle: 'My Business Accounts',
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      layoutWidget: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: Ratioz.stratosphere,
            bottom: Ratioz.horizon,
        ),
        itemCount: bzzModels.length,
        itemBuilder: (_, index){

          final BzModel _bzModel = bzzModels[index];

          return DreamBox(
            height: 100,
            width: 350,
            verseMaxLines: 2,
            margins: const EdgeInsets.only(bottom: 10),
            verse: _bzModel.name,
            icon: _bzModel.logo,
            onTap: () => goToMyBzScreen(
              context: context,
              myBzModel: _bzModel,
            ),

          );

          /*
          /// PLAN : CHANGE THOSE DREAM BOX BUTTONS INTO STATIC HEADERS
          return StaticHeader(
            flyerBoxWidth: appBarWidth(context),
            opacity: 1,
            bzModel: _bzModel,
            onTap: () async {
              await goToNewScreen(context, MyBzScreen(bzModel: _bzModel,));
              },
          );
           */

        },
      ),
    );

  }
}
