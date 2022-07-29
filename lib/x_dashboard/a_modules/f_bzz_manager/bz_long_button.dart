import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip_with_headline.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzLongButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLongButton({
    @required this.bzModel,
    this.boxWidth,
    this.showID = true,
    this.onTap,
    this.isSelected = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double boxWidth;
  final bool showID;
  final Function onTap;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  static const double height = 60;
  static const double bzButtonMargin = Ratioz.appBarPadding;
  static const double extent = BzLongButton.height + bzButtonMargin;
// -----------------------------------------------------------------------------
  Future<void> _onTap({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    if (onTap != null){
      onTap();
    }

    else {

      final double _dialogHeight = Scale.superScreenHeight(context) * 0.8;
      final double _clearDialogWidth = BottomDialog.clearWidth(context);

      await BottomDialog.showBottomDialog(
        context: context,
        title: bzModel.name,
        draggable: true,
        height: _dialogHeight,
        child: SizedBox(
          width: _clearDialogWidth,
          height: BottomDialog.clearHeight(
              draggable: true,
              titleIsOn: true,
              context: context,
              overridingDialogHeight: _dialogHeight),
          // color: Colorz.BloodTest,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              SizedBox(
                width: _clearDialogWidth,
                height: FlyerBox.headerStripHeight(
                  headerIsExpanded: false,
                  flyerBoxWidth: _clearDialogWidth,
                ),
                child: Column(
                  children: <Widget>[

                    Container(),

                    // MiniHeaderStrip(
                    //   bzPageIsOn: _superFlyer.nav.bzPageIsOn,
                    //   flyerBoxWidth: _clearDialogWidth,
                    //   bzModel: _superFlyer.bz,
                    //   bzCity: _superFlyer.bzCity,
                    //   bzCountry: _superFlyer.bzCountry,
                    //   followIsOn: _superFlyer.rec.followIsOn,
                    //   onCallTap: _superFlyer.rec.onCallTap,
                    //   onFollowTap: _superFlyer.rec.onFollowTap,
                    //   authorID: _superFlyer.authorID,
                    //   flyerShowsAuthor: _superFlyer.flyerShowsAuthor,
                    //       ),

                  ],
                ),
              ),

              DataStripWithHeadline(
                dataKey: 'bzName',
                dataValue: bzModel.name,
              ),

              DataStripWithHeadline(
                dataKey: 'bzLogo',
                dataValue: bzModel.logo,
              ),

              DataStripWithHeadline(
                dataKey: 'bzID',
                dataValue: bzModel.id,
              ),

              DataStripWithHeadline(
                dataKey: 'bzType',
                dataValue: bzModel.bzTypes,
              ),

              DataStripWithHeadline(
                dataKey: 'bzForm',
                dataValue: bzModel.bzForm,
              ),

              DataStripWithHeadline(
                dataKey: 'createdAt',
                dataValue: bzModel.createdAt,
              ),

              DataStripWithHeadline(
                dataKey: 'accountType',
                dataValue: bzModel.accountType,
              ),

              DataStripWithHeadline(
                dataKey: 'bzScope',
                dataValue: bzModel.scope,
              ),

              DataStripWithHeadline(
                dataKey: 'bzZone',
                dataValue: bzModel.zone,
              ),

              DataStripWithHeadline(
                dataKey: 'bzAbout',
                dataValue: bzModel.about,
              ),

              DataStripWithHeadline(
                dataKey: 'bzPosition',
                dataValue: bzModel.position,
              ),

              DataStripWithHeadline(
                dataKey: 'bzContacts',
                dataValue: bzModel.contacts,
              ),

              DataStripWithHeadline(
                dataKey: 'bzAuthors',
                dataValue: bzModel.authors,
              ),

              DataStripWithHeadline(
                dataKey: 'bzShowsTeam',
                dataValue: bzModel.showsTeam,
              ),

              DataStripWithHeadline(
                dataKey: 'bzIsVerified',
                dataValue: bzModel.isVerified,
              ),

              DataStripWithHeadline(
                dataKey: 'bzState',
                dataValue: bzModel.bzState,
              ),

              const DataStripWithHeadline(
                dataKey: 'bzTotalFollowers',
                dataValue: 0,
              ),

              const DataStripWithHeadline(
                dataKey: 'bzTotalSaves',
                dataValue: 0,
              ),

              const DataStripWithHeadline(
                dataKey: 'bzTotalShares',
                dataValue: 0,
              ),

              const DataStripWithHeadline(
                dataKey: 'bzTotalSlides',
                dataValue: 0,
              ),

              const DataStripWithHeadline(
                dataKey: 'bzTotalViews',
                dataValue: 0,
              ),

              const DataStripWithHeadline(
                dataKey: 'bzTotalCalls',
                dataValue: 0,
              ),

              DataStripWithHeadline(
                dataKey: 'flyersIDs,',
                dataValue: bzModel.flyersIDs,
              ),

              const DataStripWithHeadline(
                dataKey: 'bzTotalFlyers',
                dataValue: 0,
              ),

              // Container(
              //     width: _clearDialogWidth,
              //     height: 100,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //
              //         DreamBox(
              //           height: 80,
              //           width: 80,
              //           verse: 'Delete User',
              //           verseMaxLines: 2,
              //           onTap: () => _deleteUser(_userModel),
              //         ),
              //
              //       ],
              //     )
              // )

            ],
          ),
        ),
      );

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _zoneString = ZoneModel.generateZoneString(
        context: context,
        zoneModel: bzModel?.zone,
    );

    final String _bzIDString = showID == true ? '\n${bzModel?.id}' : null;

    return DreamBox(
      height: height,
      width: BldrsAppBar.width(context, boxWidth: boxWidth),
      color: isSelected == true? Colorz.yellow255 : Colorz.white10,
      verseColor: isSelected == true ? Colorz.black255 : Colorz.white255,
      verse: bzModel?.name,
      icon: bzModel?.logo,
      margins: const EdgeInsets.only(top: bzButtonMargin),
      verseScaleFactor: 0.7,
      verseCentered: false,
      secondLine: '$_zoneString$_bzIDString',
      onTap: () => _onTap(
        context: context,
        bzModel: bzModel,
      ),
    );

  }
}
