import 'package:bldrs/b_views/c_main_search/a_main_search_screen/aaa_main_search_history_view.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/c_main_search/a_main_search_screen/aaa_main_search_result_view.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SearchScreenView({
    @required this.scrollController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return MaxBounceNavigator(
      boxDistance: _screenHeight,
      child: SizedBox(
        width: Scale.screenWidth(context),
        height: _screenHeight,
        // color: Colorz.BlackPlastic,
        child: Consumer<UiProvider>(
          child: const Center(child: Loading(loading: true,),),
          builder: (_, UiProvider uiProvider, Widget child) {

            final bool _isLoading = uiProvider.isLoading;

            if (_isLoading == true){
              return child;
            }

            else {

              return Selector<SearchProvider, bool>(
                selector: (_, SearchProvider searchProvider) => searchProvider.isSearchingFlyersAndBzz,
                builder: (BuildContext context, bool isSearchingFlyersAndBzz, Widget child){

                  if (isSearchingFlyersAndBzz == true){
                    return const SearchResultView();
                  }

                  else {
                    return SearchHistoryView(
                      scrollController: scrollController,
                    );
                  }


                },
              );

            }

          },
        ),
      ),

    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

/*

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
                //               //           verse:  'Delete User',
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


 */

/*

 */
