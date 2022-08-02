import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/c_review_bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/xxx_new_review_creator_tree.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/real/real_coll_paginator.dart';
import 'package:bldrs/e_db/real/ops/review_ops.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SubmittedReviews extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SubmittedReviews({
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.reviewPageVerticalController,
    @required this.flyerBoxWidth,
    @required this.flyerID,
    @required this.onSubmit,
    @required this.reviewTextController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final ScrollController reviewPageVerticalController;
  final double flyerBoxWidth;
  final String flyerID;
  final Function onSubmit;
  final TextEditingController reviewTextController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('SubmittedReviews'),
      width: pageWidth,
      height: pageHeight,
      child: RealCollPaginator(
        scrollController: reviewPageVerticalController,
        // realOrderBy: RealOrderBy.value,
        nodePath: ReviewRealOps.createRealPath(flyerID),
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

          /// LOADING
          if (isLoading == true){
            return const Center(
              child: Loading(loading: true,),
            );
          }

          /// FINISHED LOADING
          else {

            final List<ReviewModel> _reviews = ReviewModel.decipherReviews(
              maps: maps,
              fromJSON: true,
            );

            // /// NO REVIEWS YET
            // if (Mapper.checkCanLoopList(_reviews) == false){
            //   return const SuperVerse(
            //     verse: 'Be the first to review this flyer\n'
            //         'Tell others what you think about it,\n'
            //         'The world values your opinion',
            //     maxLines: 5,
            //   );
            // }
            //
            // /// REVIEWS
            // else {

              return ListView.builder(
                controller: reviewPageVerticalController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  bottom: Ratioz.horizon,
                ),
                itemCount: _reviews.length + 1,
                itemBuilder: (_, int index){

                  if (index == 0){
                    return NewReviewCreatorTree(
                        pageWidth: pageWidth,
                        flyerBoxWidth: flyerBoxWidth,
                        pageHeight: pageHeight,
                        onEditReview: (){blog('SHOULD EDIT REVIEW');},
                        onSubmitReview: onSubmit,
                        reviewTextController: TextEditingController()
                    );
                  }

                  else {

                    return ReviewBubble(
                      pageWidth : pageWidth,
                      flyerBoxWidth: flyerBoxWidth,
                      reviewModel: _reviews[index - 1],
                      // specialReview: true,
                    );

                  }


                },
              );

            }

          // }

        },
      ),
    );

  }
}
