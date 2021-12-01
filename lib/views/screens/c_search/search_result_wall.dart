import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_shelf.dart';
import 'package:flutter/material.dart';

class SearchResultWall extends StatelessWidget {
  final List<KW> keywords;
  final List<BzModel> bzz;
  final List<AuthorModel> authors;
  final List<FlyerModel> flyers;

  const SearchResultWall({
    @required this.keywords,
    @required this.bzz,
    @required this.authors,
    @required this.flyers,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    // const double _buttonHeight = 60;
    // final double _buttonWidth = _screenWidth - Ratioz.appBarMargin * 2;
    // const double _bzButtonMargin = Ratioz.appBarPadding;
    // final double _clearDialogWidth = BottomDialog.dialogClearWidth(context);

    return Container(
      width: _screenWidth,
      height: _screenHeight,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: bzz?.length,
        padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2),

        itemBuilder: (ctx, index){

          final BzModel _bz = bzz[index];

          return

              FlyersShelf(
                title: _bz.name,
                flyerSizeFactor: 0.3,
                titleIcon: _bz.logo,
                flyerOnTap: (){print('flyer tapped');},
                onScrollEnd: (){print('scroll ended');},
                // flyersType: FlyerTypeClass.concludePossibleFlyerTypesForBz(bzType: _bz.bzType)[0],
                flyers: [FlyerModel.dummyFlyer()],
              );

            // DreamBox(
            //   height: _buttonHeight,
            //   width: _buttonWidth,
            //   color: Colorz.white20,
            //   verse: _bz.name,
            //   secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
            //   icon: _bz.logo,
            //   margins: const EdgeInsets.only(top: _bzButtonMargin),
            //   verseScaleFactor: 0.7,
            //   verseCentered: false,
            //   onTap: () async {
            //
            //     final double _dialogHeight = _screenHeight * 0.8;
            //
            //     final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
            //     final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
            //     final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);
            //
            //     await BottomDialog.showBottomDialog(
            //       context: context,
            //       title: _bz.name,
            //       draggable: true,
            //       height: _dialogHeight,
            //       child: Container(
            //         width: _clearDialogWidth,
            //         height: BottomDialog.dialogClearHeight(draggable: true, titleIsOn: true, context: context, overridingDialogHeight: _dialogHeight),
            //         // color: Colorz.BloodTest,
            //         child: MaxBounceNavigator(
            //           child: ListView(
            //             physics: const BouncingScrollPhysics(),
            //             children: <Widget>[
            //
            //               Container(
            //                 width: _clearDialogWidth,
            //                 height: FlyerBox.headerStripHeight(false, _clearDialogWidth),
            //                 child: Column(
            //
            //                   children: <Widget>[
            //
            //                     MiniHeaderStrip(
            //                       superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
            //                         onHeaderTap: (){},
            //                         bzModel: _bz,
            //                         bzCountry: _bzCountry,
            //                         bzCity: _bzCity,
            //                       ),
            //                       flyerBoxWidth: _clearDialogWidth,
            //                     ),
            //
            //                   ],
            //
            //                 ),
            //               ),
            //
            //
            //
            //               // DataStrip(dataKey: 'bzName', dataValue: _bz.name, ),
            //               // DataStrip(dataKey: 'bzLogo', dataValue: _bz.logo, ),
            //               // DataStrip(dataKey: 'bzID', dataValue: _bz.bzID, ),
            //               // DataStrip(dataKey: 'bzType', dataValue: _bz.bzType, ),
            //               // DataStrip(dataKey: 'bzForm', dataValue: _bz.bzForm, ),
            //               // DataStrip(dataKey: 'createdAt', dataValue: _bz.createdAt, ),
            //               // DataStrip(dataKey: 'accountType', dataValue: _bz.accountType, ),
            //               // DataStrip(dataKey: 'bzScope', dataValue: _bz.scope, ),
            //               // DataStrip(dataKey: 'bzZone', dataValue: _bz.zone, ),
            //               // DataStrip(dataKey: 'bzAbout', dataValue: _bz.about, ),
            //               // DataStrip(dataKey: 'bzPosition', dataValue: _bz.position, ),
            //               // DataStrip(dataKey: 'bzContacts', dataValue: _bz.contacts, ),
            //               // DataStrip(dataKey: 'bzAuthors', dataValue: _bz.authors, ),
            //               // DataStrip(dataKey: 'bzShowsTeam', dataValue: _bz.showsTeam, ),
            //               // DataStrip(dataKey: 'bzIsVerified', dataValue: _bz.isVerified, ),
            //               // DataStrip(dataKey: 'bzState', dataValue: _bz.bzState, ),
            //               // DataStrip(dataKey: 'bzTotalFollowers', dataValue: _bz.totalFollowers, ),
            //               // DataStrip(dataKey: 'bzTotalSaves', dataValue: _bz.totalSaves, ),
            //               // DataStrip(dataKey: 'bzTotalShares', dataValue: _bz.totalShares, ),
            //               // DataStrip(dataKey: 'bzTotalSlides', dataValue: _bz.totalSlides, ),
            //               // DataStrip(dataKey: 'bzTotalViews', dataValue: _bz.totalViews, ),
            //               // DataStrip(dataKey: 'bzTotalCalls', dataValue: _bz.totalCalls, ),
            //               // DataStrip(dataKey: 'flyersIDs,', dataValue: _bz.flyersIDs, ),
            //               // DataStrip(dataKey: 'bzTotalFlyers', dataValue: _bz.totalFlyers, ),
            //
            //
            //               // Container(
            //               //     width: _clearDialogWidth,
            //               //     height: 100,
            //               //     child: Row(
            //               //       mainAxisAlignment: MainAxisAlignment.center,
            //               //       crossAxisAlignment: CrossAxisAlignment.center,
            //               //       children: <Widget>[
            //               //
            //               //         DreamBox(
            //               //           height: 80,
            //               //           width: 80,
            //               //           verse: 'Delete User',
            //               //           verseMaxLines: 2,
            //               //           onTap: () => _deleteUser(_userModel),
            //               //         ),
            //               //
            //               //       ],
            //               //     )
            //               // )
            //
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //
            //   },
            // );

        },
      ),
    );
  }
}
