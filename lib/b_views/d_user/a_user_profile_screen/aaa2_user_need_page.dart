import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/user/need_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/b_need_editor_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class UserNeedsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserNeedsPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel _userModel = UsersProvider.proGetMyUserModel(
    //   context: context,
    //   listen: true,
    // );

    final NeedModel dummyNeed = NeedModel.dummyNeed(context);

    return PageBubble(
      screenHeightWithoutSafeArea: Scale.superScreenHeight(context) - Ratioz.horizon * 2,
      appBarType: AppBarType.basic,
      color: Colorz.white10,
      childrenAlignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        // padding: Stratosphere.stratosphereSandwich,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// TITLE
            const SuperVerse(
              verse: Verse(
                text: 'phid_my_needs',
                translate: true,
              ),
              size: 3,
            ),

            /// NEED TYPE
            SuperVerse(
                verse: Verse(
                  text: NeedModel.getNeedTypePhid(dummyNeed.needType),
                  translate: true,
                ),
            ),

            /// SPECS
            if (Mapper.checkCanLoopList(dummyNeed.scope) == true)
              SpecsBuilder(
                pageWidth: PageBubble.clearWidth(context),
                specs: SpecModel.generateSpecsByPhids(
                  context: context,
                  phids: dummyNeed.scope,
                ),
                onSpecTap: ({SpecModel value, SpecModel unit}){
                  blog('NEED : UserNeedsPage : onSpecTap');
                  value.blogSpec();
                  unit?.blogSpec();
                },
                onDeleteSpec: ({SpecModel value, SpecModel unit}){
                  blog('NEED : UserNeedsPage : onDeleteSpec');
                  value.blogSpec();
                  unit?.blogSpec();
                },
              ),

            DreamBox(
              height: 50,
              verse: const Verse(
                text: 'phid_edit_needs',
                translate: true,
              ),
              onTap: () async {

                await Nav.goToNewScreen(
                  context: context,
                  screen: const NeedEditorScreen(),
                );

              },
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
