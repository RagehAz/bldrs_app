import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/user/need_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/b_need_editor_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserNeedsBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserNeedsBanner({
    this.userModel,
    Key key
  }) : super(key: key);

  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = userModel ?? UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return Bubble(
      headerViewModel: BubbleHeaderVM(
          hasMoreButton: true,
          onMoreButtonTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const NeedEditorScreen(),
            );

          }
      ),
      childrenCentered: true,

      columnChildren: <Widget>[

        /// IM CURRENTLY
        const SuperVerse(
          verse: Verse(
            text: 'phid_im_currently',
            translate: true,
          ),
          italic: true,
          shadow: true,
          margin: 5,
        ),

        /// NEED TYPE
        SuperVerse(
          verse: Verse(
            text: NeedModel.getNeedTypePhid(_userModel.need?.needType),
            translate: true,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          size: 4,
          color: Colorz.yellow255,
          italic: true,
        ),

        /// NEED LOCALE
        ZoneLine(
          zoneModel: _userModel?.need?.zone,
          // showCity: true,
          // showDistrict: true,
        ),

        /// NOTES
        SuperVerse(
          verse: Verse(
            text: _userModel.need.notes,
            translate: false,
          ),
          labelColor: Colorz.white20,
          width: PageBubble.clearWidth(context),
          margin: 30,
          maxLines: 100,
        ),

        /// SPECS
        if (Mapper.checkCanLoopList(_userModel.need?.scope) == true)
          SpecsBuilder(
            pageWidth: PageBubble.clearWidth(context),
            specs: SpecModel.generateSpecsByPhids(
              context: context,
              phids: _userModel.need?.scope,
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

      ],

    );
  }
  /// --------------------------------------------------------------------------
}
