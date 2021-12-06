import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/records/review_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_card.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_creator.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatefulWidget {
  final double flyerBoxWidth;
  final SuperFlyer superFlyer;

  const ReviewBubble({
    @required this.flyerBoxWidth,
    @required this.superFlyer,
    Key key,
  }) : super(key: key);

  @override
  _ReviewBubbleState createState() => _ReviewBubbleState();
}

class _ReviewBubbleState extends State<ReviewBubble> {
  UserModel _userModel;
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


        if(mounted){

          _userModel = await UserFireOps.readUser(
            context: context,
            userID: FireAuthOps.superUserID(),
          );

          _reviews = await FireFlyerOps.readAllReviews(
            context: context,
            flyerID: widget.superFlyer.flyerID,
          );

        }

      });

    }
    _isInit = false;

  }
// -----------------------------------------------------------------------------
  Future<void> _reloadReviews() async {
    /// TASK : THIS IS SUPER EXPENSIVE
    final List<ReviewModel> reviews = await FireFlyerOps.readAllReviews(
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

    final double _bubbleWidth = widget.flyerBoxWidth - (Ratioz.appBarPadding * 2);
    const EdgeInsets _bubbleMargins = const EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    // double _peopleBubbleBoxHeight = widget.flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;

    final double _cornerSmall = widget.flyerBoxWidth * Ratioz.xxflyerTopCorners;
    final double _cornerBig = (widget.flyerBoxWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;

    final BorderRadius _bubbleCorners = Borderers.superBorderOnly(
      context: context,
      enTopLeft: _cornerSmall,
      enTopRight: _cornerSmall,
      enBottomLeft: _cornerBig,
      enBottomRight: _cornerBig,
    );

    final double _cardCorners = _cornerSmall - Ratioz.appBarMargin;

    return Bubble(
      key: widget.key,
      width: _bubbleWidth,
      margins: _bubbleMargins,
      corners: _bubbleCorners,
      title: 'Flyer Reviews',
      leadingIcon: Iconz.bxDesignsOn,
      LeadingAndActionButtonsSizeFactor: 1,
      columnChildren: <Widget>[

        ReviewCreator(
          width: _bubbleWidth,
          corners: _cardCorners,
          userModel: _userModel,
          superFlyer: widget.superFlyer,
          reloadReviews: _reloadReviews,
        ),

        ReviewsStreamBubbles(
          superFlyer: widget.superFlyer,
          userModel: _userModel,
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
  final UserModel userModel;
  final List<ReviewModel> reviews;

  const ReviewsStreamBubbles({
    @required  this.superFlyer,
    @required this.bubbleWidth,
    @required this.cardCorners,
    @required this.userModel,
    @required this.reviews,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int _length = reviews?.length ?? 0;

    return Container(
      width: bubbleWidth,
      child: Column(

        children: <Widget>[

          ...List<Widget>.generate
            (_length, (int index) =>
              ReviewCard(
                width: bubbleWidth,
                corners: cardCorners,
                review: reviews[index],
                userModel: userModel,
                flyerID: superFlyer.flyerID,
                onShowReviewOptions: () => superFlyer.rec.onShowReviewOptions(reviews[index]),
              ),
          )
        ],
      ),
    );
  }
}
