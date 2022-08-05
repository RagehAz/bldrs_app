import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/reviews_part/b_review_bubble.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/paginator_notifiers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewsBuilder({
    @required this.scrollController,
    @required this.reviewsMaps,
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.reviewTextController,
    @required this.flyerModel,
    @required this.paginatorNotifiers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final ScrollController scrollController;
  final List<Map<String, dynamic>> reviewsMaps;
  final TextEditingController reviewTextController;
  final FlyerModel flyerModel;
  final PaginatorNotifiers paginatorNotifiers;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<ReviewModel> reviews = ReviewModel.decipherReviews(
      maps: reviewsMaps,
      fromJSON: false,
    );

    return ListView.builder(
      key: const ValueKey<String>('ReviewsBuilder'),
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: ReviewBubble.spacer,
        bottom: Ratioz.horizon,
      ),
      itemCount: reviews.length + 1,
      itemBuilder: (_, int index){

        /// REVIEW CREATOR
        if (index == 0){
          return ReviewBubble(
            flyerModel: flyerModel,
            pageWidth: pageWidth,
            reviewTextController: reviewTextController,
            isCreatorMode: true,
            paginatorNotifiers: paginatorNotifiers,
          );
        }

        /// SUBMITTED REVIEWS
        else {

          return ReviewBubble(
            flyerModel: flyerModel,
            pageWidth : pageWidth,
            reviewModel: reviews[index - 1],
            paginatorNotifiers: paginatorNotifiers,
            isCreatorMode: false,
            // specialReview: true,
          );

        }

      },
    );

  }
}
