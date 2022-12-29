import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/b_need_editor_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class UserNeedsBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserNeedsBanner({
    @required this.userModel,
    this.editorMode = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final bool editorMode;
  /// --------------------------------------------------------------------------
  Future<void> onGoToNeedsEditorScreen(BuildContext context) async {
    await Nav.goToNewScreen(
      context: context,
      screen: const NeedEditorScreen(),
    );
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      width: BldrsAppBar.width(context),
      bubbleHeaderVM: BubbleHeaderVM(
          hasMoreButton: true,
          onMoreButtonTap: editorMode == true ? () => onGoToNeedsEditorScreen(context) : null,
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
            text: NeedModel.getNeedTypePhid(userModel?.need?.needType),
            translate: true,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          size: 4,
          color: Colorz.yellow255,
          italic: true,
        ),

        /// NEED LOCALE
        ZoneLine(
          zoneModel: userModel?.zone,
          // showCity: true,
          // showDistrict: true,
        ),

        /// NOTES
        SuperVerse(
          verse: Verse(
            text: userModel?.need?.notes,
            translate: false,
          ),
          labelColor: Colorz.white20,
          width: PageBubble.clearWidth(context),
          margin: 30,
          maxLines: 100,
        ),

        /// SPECS
        if (Mapper.checkCanLoopList(userModel?.need?.scope) == true)
          SpecsBuilder(
            pageWidth: PageBubble.clearWidth(context),
            specs: SpecModel.generateSpecsByPhids(
              context: context,
              phids: userModel?.need?.scope,
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
