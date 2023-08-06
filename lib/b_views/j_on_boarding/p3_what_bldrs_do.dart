import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/animators/widgets/widget_waiter.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/b_views/j_on_boarding/components/onboarding_headline.dart';
import 'package:bldrs/b_views/j_on_boarding/components/phids_wheel.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/protocols/a_chain_protocols.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class CWhatBldrsDo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CWhatBldrsDo({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double width = OnBoardingScreen.getBubbleWidth();
    final double height = OnBoardingScreen.getPagesZoneHeight();
    // --------------------
    final double _bzTypeIconSize = height * 0.07;
    final double _tileWidth = width - _bzTypeIconSize;
    // const double _titleMargin = 5;

    const double _wheelBoxHeight = 50;
    // --------------------
    return FloatingList(
      width: width,
      height: height,
      mainAxisAlignment: MainAxisAlignment.start,
      boxAlignment: Alignment.topCenter,
      columnChildren: [

        /// HEADLINE
        const OnBoardingHeadline(
          phid: 'phid_what_do_bldrs_do',
        ),

        ...List.generate(BzTyper.bzTypesList.length, (index){

          final BzType _bzType = BzTyper.bzTypesList[index];
          final String _bzTypePhid = BzTyper.getBzTypePhid(
            bzType: _bzType,
            // pluralTranslation: true,
            nounTranslation: false,
          );
          final Verse _bzTypeVerse = Verse(
              id: _bzTypePhid,
              translate: true,
              casing: Casing.upperCase,
            );
          final String? _bzTypeIcon = BzTyper.getBzTypeIconOn(_bzType);
          final String _bzTypePublishesPhid = BzTyper.getBzTypePublishesPhid(_bzType);

          final List<FlyerType> _flyerTypes = FlyerTyper.concludePossibleFlyerTypesByBzType(
              bzType: _bzType,
          );
          // final String? _flyerTypeIcon = FlyerTyper.flyerTypeIcon(
          //   flyerType: _flyerTypes.first,
          //   isOn: true,
          // );
          // final Verse _flyerTypeVerse = Verse(
          //   id: _bzTypePhid,
          //   translate: true,
          //   casing: Casing.upperCase,
          // );

          return WidgetWaiter(
            isOn: true,
            waitDuration: Duration(seconds: 1 * index),
            child: WidgetFader(
              fadeType: FadeType.fadeIn,
              child: Container(
                width: _tileWidth,
                // height: _bzTypeIconSize + _wheelBoxHeight,
                decoration: const BoxDecoration(
                  borderRadius: Borderers.constantCornersAll15,
                  color: Colorz.white10,
                ),
                margin: const EdgeInsets.only(bottom: 5),
                child: Column(
                  children: <Widget>[

                    /// TYPE AND
                    BldrsBox(
                      width: _tileWidth,
                      icon: _bzTypeIcon,
                      height: _bzTypeIconSize,
                      verse: _bzTypeVerse,
                      verseWeight: VerseWeight.thin,
                      verseItalic: true,
                      verseCentered: false,
                      corners: BorderRadius.zero,
                      verseScaleFactor: _bzTypeIconSize * 0.027,
                      secondLine: Verse(
                        id: _bzTypePublishesPhid,
                        translate: true,
                      ),
                      secondVerseMaxLines: 1,
                      bubble: false,
                    ),

                    /// PHIDS WHEELS
                    ...List.generate(_flyerTypes.length, (index){

                      final List<String> _phids = ChainProtocols.superGetAllPhidsByFlyerType(
                        flyerType: _flyerTypes[index],
                        onlyUseZoneChains: false,
                      );

                      return PhidsWheel(
                        width: _tileWidth,
                        height: _wheelBoxHeight,
                        phids: _phids,
                      );

                    }),


                  ],
                ),
              ),
            ),
          );

        }),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
