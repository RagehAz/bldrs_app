// ignore_for_file: avoid_redundant_argument_values

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class RoutingTestBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const RoutingTestBar({
    super.key
  });
  // --------------------------------------------------------------------------
  Widget _goTo(String routeSettingsName, {bool good = false, String? args}) {
    return theButton(
      text: routeSettingsName,
      good: good,
      onTap: () async {
        await Routing.goTo(
          route: routeSettingsName,
          arg: args
        );
        },
    );
  }
  // ------
  Widget theButton({
    required String text,
    required Function onTap,
    bool good = false,
  }){
    return BldrsBox(
      height: 55,
      maxWidth: 90,
      verseMaxLines: 3,
      verseScaleFactor: 0.4,
      verseWeight: VerseWeight.thin,
      verse: Verse.plain(text),
      color: Colorz.white20,
      margins: const EdgeInsets.only(right: 2),
      verseColor: good == true ? Colorz.green255 : Colorz.white200,
      onTap: onTap,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const String userID = '1H2osf0ITLXJ9wVgcxPEYrkR2Px1';
    const String bzID = 'nVqAKcz2QxSY6qDz6tjc';
    const String flyerID = 'XTTsVsZAIoisvL4v0XGj';
    const String reviewID = 'r9rAUqi5SHj0N6NLJuyS';
    // --------------------
    final List<String> _allBids = TabName.generateAllBids(context: context, listen: true);
    // --------------------
    return FloatingList(
      width: Scale.screenWidth(context),
      height: 55,
      scrollDirection: Axis.horizontal,
      boxColor: Colorz.darkBlue,
      columnChildren: <Widget>[
        // -----------------------------------------------------------------------------

        /// SCREENS

        // --------------------
        _goTo(ScreenName.logo, good: false),
        _goTo(ScreenName.home, good: false),
        _goTo('${ScreenName.userPreview}:$userID', good: true),
        _goTo('${ScreenName.bzPreview}:$bzID', good: true),
        _goTo('${ScreenName.flyerPreview}:$flyerID', good: true),
        _goTo('${ScreenName.flyerReviews}:${flyerID}_$reviewID', good: true),
        _goTo('${ScreenName.flyerReviews}:$flyerID', good: true),
        _goTo(ScreenName.underConstruction, good: false),
        _goTo(ScreenName.banner, good: false),
        _goTo(ScreenName.privacy, good: false),
        _goTo(ScreenName.terms, good: false),
        _goTo(ScreenName.deleteMyData, good: false),
        _goTo(ScreenName.dashboard, good: false),
        // -----------------------------------------------------------------------------

        /// CUSTOM ROUTING

        // --------------------
        theButton(
          text: 'Back from home',
          onTap: Routing.backFromHomeScreen,
        ),
        // --------------------
        theButton(
          text: 'Restart to after home route',
          onTap: () async {

            // await ScreenRouter.restartToAfterHomeRoute(
            //   routeName: _routeName,
            //   arguments:
            // );

          },
        ),
        // -----------------------------------------------------------------------------

        /// TABS

        // --------------------
        ...List.generate(_allBids.length, (index){

          String _bid = _allBids[index];
          String? _arg;

          if (TabName.checkBidIsBidBz(bid: _bid) == true){
            _arg = TabName.getBzIDFromBidBz(bzBid: _bid);
            _bid = TabName.getBidFromBidBz(bzBid: _bid)!;
          }

          return theButton(
              text: '$_bid : ${_arg?? ''}',
              onTap: () => Routing.goTo(
                  route: _bid,
                  arg: _arg,
              ),
          );

        }),
      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
