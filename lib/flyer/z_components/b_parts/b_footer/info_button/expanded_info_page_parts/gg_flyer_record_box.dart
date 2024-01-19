import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_save_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_share_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_view_model.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/ggg_mini_user_banner.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/paginators/records_paginators/flyer_saves_paginator.dart';
import 'package:bldrs/z_components/paginators/records_paginators/flyer_shares_paginator.dart';
import 'package:bldrs/z_components/paginators/records_paginators/flyer_views_paginator.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';


class FlyerRecordsBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerRecordsBox({
    required this.pageWidth,
    required this.headlineVerse,
    required this.icon,
    required this.recordType,
    required this.flyerID,
    required this.bzID,
    super.key
  });
  /// -----------------------
  final double pageWidth;
  final Verse headlineVerse;
  final String icon;
  final RecordType recordType;
  final String flyerID;
  final String bzID;
  // --------------------------------------------------------------------------
  static int _calculateLimit({
    required double pageWidth,
  }){

    final double _clearWidth = pageWidth;
    final double _userBannerWidth = MiniUserBanner.getWidthByPageWidth(
      pageWidth: pageWidth,
    );
    const double _bannerSpacing = MiniUserBanner.spacing;

    final double _unitWidth = _userBannerWidth + _bannerSpacing;
    final double _division = _clearWidth / _unitWidth;
    final int _limit = (_division * 2.5).floor();

    return _limit;

  }

  @override
  Widget build(BuildContext context) {

    final int _limit = _calculateLimit(
      pageWidth: pageWidth,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// HEADLINE
        BldrsBox(
          width: pageWidth - 30,
          height: 30,
          verse: headlineVerse,
          verseWeight: VerseWeight.thin,
          verseItalic: true,
          icon: icon,
          iconSizeFactor: 0.6,
          verseScaleFactor: 1 / 0.6,
          bubble: false,
          verseCentered: false,
          margins: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        ),

        /// VIEWS PAGINATOR
        if (recordType == RecordType.view)
          FlyerViewsPaginator(
              flyerID: flyerID,
              bzID: bzID,
              limit: _limit,
              builder: (_, List<FlyerViewModel>? records, bool loading, Widget? child, ScrollController controller){

                return UsersStripBuilder(
                  width: pageWidth,
                  scrollController: controller,
                  usersIDs: FlyerViewModel.getUsersIDsFromRecords(
                    models: records,
                  ),
                );

              }
              ),

        /// SAVES PAGINATOR
        if (recordType == RecordType.save)
          FlyerSavesPaginator(
              flyerID: flyerID,
              bzID: bzID,
              limit: _limit,
              builder: (_, List<FlyerSaveModel>? records, bool loading, Widget? child, ScrollController controller){

                return UsersStripBuilder(
                  width: pageWidth,
                  scrollController: controller,
                  usersIDs: FlyerSaveModel.getUsersIDsFromRecords(
                    models: records,
                  ),
                );


              }
              ),

        /// SHARES PAGINATOR
        if (recordType == RecordType.share)
          FlyerSharesPaginator(
              flyerID: flyerID,
              bzID: bzID,
              limit: _limit,
              builder: (_, List<FlyerShareModel>? records, bool loading, Widget? child, ScrollController controller){

                return UsersStripBuilder(
                  width: pageWidth,
                  scrollController: controller,
                  usersIDs: FlyerShareModel.getUsersIDsFromRecords(
                    models: records,
                  ),
                );

              }
              ),

      ],
    );

  }
  // --------------------------------------------------------------------------
}

class UsersStripBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const UsersStripBuilder({
    required this.usersIDs,
    required this.scrollController,
    required this.width,
    super.key
  });
  // -----------------------
  final List<String> usersIDs;
  final ScrollController scrollController;
  final double width;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(usersIDs) == false){
      return const SizedBox();
    }

    else {

      return Container(
        width: width,
        height: MiniUserBanner.getHeightByPageWidth(pageWidth: width) + 20,
        decoration: const BoxDecoration(
          color: Colorz.white20,
          borderRadius: Borderers.constantCornersAll10,
        ),
        child: ScrollConfiguration(
          behavior: const AppScrollBehavior(),
          child: ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            itemCount: usersIDs.length,
            itemBuilder: (_, int index){

              return FutureBuilder(
                future: UserProtocols.fetch(userID: usersIDs[index]),
                builder: (_, AsyncSnapshot<UserModel?> snapshot){
                  final UserModel? _user = snapshot.data;
                  return MiniUserBanner(
                    width: MiniUserBanner.getWidthByPageWidth(
                      pageWidth: width,
                    ),
                    userModel: _user,
                  );
                  },
              );

              },
          ),
        ),
      );

    }


  }
  // --------------------------------------------------------------------------
}
