import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/records/review_model.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyer_streamer.dart';
import 'package:bldrs/providers/users/user_streamer.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/PersonButton.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/review_card.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/review_creator.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatefulWidget {
  final double flyerZoneWidth;
  final SuperFlyer superFlyer;
  final Key key;

  const ReviewBubble({
    @required this.flyerZoneWidth,
    @required this.superFlyer,
    this.key,
  });

  @override
  _ReviewBubbleState createState() => _ReviewBubbleState();
}

class _ReviewBubbleState extends State<ReviewBubble> {
  TinyUser _tinyUser;
  List<ReviewModel> _reviews;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    // _tinyUser = TinyUser.emptyTinyUser();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_isInit){
      _triggerLoading().then((_) async {

        _tinyUser = await UserOps().readTinyUserOps(
          context: context,
          userID: superUserID(),
        );

        _reviews = await FlyerOps.readAllReviews(
          context: context,
          flyerID: widget.superFlyer.flyerID,
        );

      });

    }
    _isInit = false;

  }
// -----------------------------------------------------------------------------
  Future<void> _reloadReviews() async {
    /// TASK : THIS IS SUPER EXPENSIVE
    List<ReviewModel> reviews = await FlyerOps.readAllReviews(
      context: context,
      flyerID: widget.superFlyer.flyerID,
    );

    setState(() {
      _reviews = reviews;
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _bubbleWidth = widget.flyerZoneWidth - (Ratioz.appBarPadding * 2);
    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    double _peopleBubbleBoxHeight = widget.flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;

    double _cornerSmall = widget.flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _cornerBig = (widget.flyerZoneWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;

    BorderRadius _bubbleCorners = Borderers.superBorderOnly(
      context: context,
      enTopLeft: _cornerSmall,
      enTopRight: _cornerSmall,
      enBottomLeft: _cornerBig,
      enBottomRight: _cornerBig,
    );

    double _cardCorners = _cornerSmall - Ratioz.appBarMargin;

    return InPyramidsBubble(
      key: widget.key,
      bubbleWidth: _bubbleWidth,
      margins: _bubbleMargins,
      corners: _bubbleCorners,
      title: 'Flyer Reviews',
      leadingIcon: Iconz.BxDesignsOn,
      LeadingAndActionButtonsSizeFactor: 1,
      columnChildren: <Widget>[

        ReviewCreator(
          width: _bubbleWidth,
          corners: _cardCorners,
          tinyUser: _tinyUser,
          superFlyer: widget.superFlyer,
          reloadReviews: _reloadReviews,
        ),

        ReviewsStreamBubbles(
          superFlyer: widget.superFlyer,
          tinyUser: _tinyUser,
          bubbleWidth: _bubbleWidth,
          cardCorners: _cardCorners,
          reviews: _reviews,
        ),

        /// bottom spaced
        Container(
          width: _bubbleWidth,
          height: _cornerBig - Ratioz.appBarMargin,
        ),

      ],
    );


  }
}

class ReviewsStreamBubbles extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double bubbleWidth;
  final double cardCorners;
  final TinyUser tinyUser;
  final List<ReviewModel> reviews;

  const ReviewsStreamBubbles({
    @required  this.superFlyer,
    @required this.bubbleWidth,
    @required this.cardCorners,
    @required this.tinyUser,
    @required this.reviews,
  });

  @override
  Widget build(BuildContext context) {

    int _length = reviews?.length ?? 0;

    return Container(
      width: bubbleWidth,
      child: Column(

        children: <Widget>[

          ...List.generate
            (_length, (index) =>
              ReviewCard(
                width: bubbleWidth,
                corners: cardCorners,
                review: reviews[index],
                tinyUser: tinyUser,
                flyerID: superFlyer.flyerID,
                onShowReviewOptions: () => superFlyer.rec.onShowReviewOptions(reviews[index]),
              ),
          )
        ],
      ),
    );
  }
}
