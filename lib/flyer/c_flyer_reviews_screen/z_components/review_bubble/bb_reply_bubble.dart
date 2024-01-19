import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/drawing/separator_line.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/flyer/c_flyer_reviews_screen/z_components/buttons/review_bubble_button.dart';
import 'package:bldrs/flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_box.dart';
import 'package:bldrs/flyer/c_flyer_reviews_screen/z_components/review_bubble/review_bubble_box.dart';
import 'package:bldrs/flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:flutter/material.dart';

class BzReplyBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzReplyBubble({
    required this.boxWidth,
    required this.reviewModel,
    required this.flyerModel,
    required this.onReplyOptionsTap,
    required this.onReplyBzBalloonTap,
    required this.isSpecialReview,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final ReviewModel? reviewModel;
  final FlyerModel? flyerModel;
  final Function onReplyOptionsTap;
  final ValueChanged<BzModel?> onReplyBzBalloonTap;
  final bool isSpecialReview;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _logoWidth = ReviewBox.userBalloonSize;
    // --------------------
    final bool _imAuthorInFlyerBz = AuthorModel.checkImAuthorInBzOfThisFlyer(
      flyerModel: flyerModel,
    );
    // --------------------
    final double _balloonWidth = boxWidth - _logoWidth - ReviewBox.spacer * 0.5;
    // --------------------
    return SizedBox(
      width: boxWidth,
      child: FutureBuilder(
        future: BzProtocols.fetchBzByFlyerID(
            flyerID: reviewModel?.flyerID,
        ),
        builder: (_, AsyncSnapshot<BzModel?> snapshot){

          final BzModel? _bzModel = snapshot.data;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// BZ LOGO
              BzLogo(
                width: _logoWidth,
                image: _bzModel?.logoPath,
                isVerified: _bzModel?.isVerified,
                zeroCornerIsOn: true,
                onTap: () => onReplyBzBalloonTap(_bzModel),
              ),

              /// SPACER
              const SizedBox(width: ReviewBox.spacer * 0.5),

              /// REPLY TEXT BOX
              ReviewBubbleBox(
                width: _balloonWidth,
                isSpecialReview: isSpecialReview,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// BZ NAME
                    BldrsText(
                      verse: Verse(
                        id: _bzModel?.name,
                        translate: false,
                      ),
                    ),

                    /// TIME
                    BldrsText(
                      verse: Verse(
                        id: BldrsTimers.calculateSuperTimeDifferenceString(
                          from: reviewModel?.replyTime,
                          to: DateTime.now(),
                        ),
                        translate: false,
                      ),
                      weight: VerseWeight.thin,
                      italic: true,
                      color: Colorz.white200,
                      scaleFactor: 0.9,
                    ),

                    /// TEXT
                    BldrsText(
                      verse: Verse.plain(reviewModel?.reply),
                      maxLines: 100,
                      centered: false,
                      weight: isSpecialReview ? VerseWeight.bold : VerseWeight.thin,
                      scaleFactor: 1.1,
                      italic: isSpecialReview,
                      color: isSpecialReview ? Colorz.yellow255 : Colorz.white255,
                    ),

                    /// SPACER
                    if (_imAuthorInFlyerBz == true)
                      const SizedBox(
                        height: 10,
                      ),

                    /// SEPARATOR LINE
                    if (_imAuthorInFlyerBz == true)
                      SeparatorLine(
                        width: _balloonWidth,
                        color: Colorz.white50,
                      ),

                    /// REPLY OPTIONS BUTTONS
                    if (_imAuthorInFlyerBz == true)
                      const SizedBox(
                        height: 10,
                      ),

                    /// REPLY OPTIONS BUTTONS
                    if (_imAuthorInFlyerBz == true)
                      SizedBox(
                        width: _balloonWidth,
                        child: Row(
                          children: <Widget>[

                            /// MORE BUTTON
                            ReviewBubbleButton(
                              count: null,
                              isOn: false,
                              phid: null,
                              icon: Iconz.more,
                              onTap: onReplyOptionsTap,
                            ),

                          ],
                        ),
                      ),

                  ],
                ),
              ),

            ],
          );

        },
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
