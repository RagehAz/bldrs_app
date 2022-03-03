import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/review_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_card.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_creator.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class OldReviewBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const OldReviewBubble({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.onEditReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    @required this.onShowReviewOptions,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final Function onEditReview;
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  final ValueChanged<ReviewModel> onShowReviewOptions;
  /// --------------------------------------------------------------------------
  @override
  _OldReviewBubbleState createState() => _OldReviewBubbleState();

  /// --------------------------------------------------------------------------
}

class _OldReviewBubbleState extends State<OldReviewBubble> {
  UserModel _userModel;
  List<ReviewModel> _reviews;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
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

    if (_isInit) {
      _triggerLoading().then((_) async {
        if (mounted) {
          _userModel = await UserFireOps.readUser(
            context: context,
            userID: FireAuthOps.superUserID(),
          );

          _reviews = await FireFlyerOps.readAllReviews(
            context: context,
            flyerID: widget.flyerModel.id,
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
      flyerID: widget.flyerModel.id,
    );

    setState(() {
      _reviews = reviews;
    });
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = widget.flyerBoxWidth - (Ratioz.appBarPadding * 2);

    const EdgeInsets _bubbleMargins = EdgeInsets.only(
        top: Ratioz.appBarPadding,
        left: Ratioz.appBarPadding,
        right: Ratioz.appBarPadding,
    );

    // double _peopleBubbleBoxHeight = widget.flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;

    final double _cornerSmall = widget.flyerBoxWidth * Ratioz.xxflyerTopCorners;

    final double _cornerBig =
        (widget.flyerBoxWidth - (Ratioz.appBarPadding * 2)) *
            Ratioz.xxflyerBottomCorners;

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
      leadingAndActionButtonsSizeFactor: 1,
      columnChildren: <Widget>[

        ReviewCreator(
          width: _bubbleWidth,
          corners: _cardCorners,
          userModel: _userModel,
          reloadReviews: _reloadReviews,
          onEditReview: widget.onEditReview,
          onSubmitReview: widget.onSubmitReview,
          reviewTextController: widget.reviewTextController,
        ),

        ReviewsStreamBubbles(
          flyerModel: widget.flyerModel,
          userModel: _userModel,
          bubbleWidth: _bubbleWidth,
          cardCorners: _cardCorners,
          reviews: _reviews,
          onShowReviewOptions: widget.onShowReviewOptions,
        ),

        /// bottom spaced
        SizedBox(
          width: _bubbleWidth,
          height: _cornerBig - Ratioz.appBarMargin,
        ),
      ],
    );
  }
}

class ReviewsStreamBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewsStreamBubbles({
    @required this.bubbleWidth,
    @required this.cardCorners,
    @required this.userModel,
    @required this.reviews,
    @required this.onShowReviewOptions,
    @required this.flyerModel,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  final double cardCorners;
  final UserModel userModel;
  final List<ReviewModel> reviews;
  final ValueChanged<ReviewModel> onShowReviewOptions;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final int _length = reviews?.length ?? 0;

    return SizedBox(
      width: bubbleWidth,
      child: Column(
        children: <Widget>[
          ...List<Widget>.generate(
            _length,
            (int index) => ReviewCard(
              width: bubbleWidth,
              corners: cardCorners,
              review: reviews[index],
              userModel: userModel,
              flyerID: flyerModel.id,
              onShowReviewOptions: () => onShowReviewOptions(reviews[index]),
            ),
          )
        ],
      ),
    );
  }
}
