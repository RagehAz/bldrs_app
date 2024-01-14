import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/x_reviews_controller.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_box.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_creator_bubble.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/b_review_view_bubble.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/a_reviews_protocols.dart';
import 'package:bldrs/e_back_end/x_queries/reviews_queries.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class SubmittedReviews extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SubmittedReviews({
    required this.pageWidth,
    required this.pageHeight,
    required this.flyerModel,
    required this.highlightReviewID,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final FlyerModel? flyerModel;
  final String? highlightReviewID;
  /// --------------------------------------------------------------------------
  @override
  State<SubmittedReviews> createState() => _SubmittedReviewsState();
  /// --------------------------------------------------------------------------
}

class _SubmittedReviewsState extends State<SubmittedReviews> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  final TextEditingController _reviewTextController = TextEditingController();
  late PaginationController _paginationController;
  // --------------------
  final ValueNotifier<bool> _isUploading = ValueNotifier<bool>(false);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _paginationController = PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {
        // -----------------------------
          await loadReviewEditorLastSession(
            context: context,
            reviewController: _reviewTextController,
            flyerID: widget.flyerModel?.id,
          );
        // -----------------------------
        // if (widget.validateOnStartup == true){
        //   Formers.validateForm(_formKey);
        // }
        // -----------------------------
          /// REMOVED
          _reviewTextController.addListener(_reviewControllerListener);
        // -------------------------------
          if (widget.highlightReviewID != null){

            // final ReviewModel _review = await ReviewFireOps.readReview(
            //   flyerID: widget.flyerModel.id,
            //   reviewID: widget.highlightReviewID,
            // );
            //
            // if (_review != null){
            //   _paginationController.addMap.value  = _review.toMap(
            //     includeID: true,
            //     includeDocSnapshot: true,
            //     // toJSON: false,
            //   );
            // }


          }
        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _reviewTextController.removeListener(_reviewControllerListener);
    _loading.dispose();
    _reviewTextController.dispose();
    _paginationController.dispose();
    _isUploading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LISTENER

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _reviewControllerListener() async {
    await saveReviewEditorSession(
      flyerID: widget.flyerModel?.id,
      reviewController: _reviewTextController,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('SubmittedReviews'),
      width: widget.pageWidth,
      height: widget.pageHeight,
      child: MaxBounceNavigator(
        child: FireCollPaginator(
          paginationQuery: reviewsPaginationQuery(
            flyerID: widget.flyerModel?.id,
          ),
          // streamQuery: reviewsStreamQuery(
          //   context: context,
          //   flyerID: widget.flyerModel?.id,
          // ),
          paginationController: _paginationController,
          // loadingWidget: const Loading(
          //   loading: true,
          // ),
          builder: (_, List<Map<String, dynamic>>? maps, bool isLoading, Widget? child){

            final List<ReviewModel> reviews = ReviewModel.decipherReviews(
              maps: maps,
              fromJSON: false,
            );

            return ListView.builder(
              key: const ValueKey<String>('ReviewsBuilder'),
              controller: _paginationController.scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                top: ReviewBox.spacer,
                bottom: Ratioz.horizon,
              ),
              itemCount: reviews.length + 1,
              itemBuilder: (_, int index){

                /// REVIEW CREATOR
                if (reviews.isEmpty || index == reviews.length){

                    return ReviewCreatorBubble(
                      pageWidth: widget.pageWidth,
                      reviewTextController: _reviewTextController,
                      globalKey: globalKey,
                      isUploading: _isUploading,
                      onReviewSubmit: () => onSubmitReview(
                        context: context,
                        textController: _reviewTextController,
                        flyerModel: widget.flyerModel,
                        paginationController: _paginationController,
                        isUploading: _isUploading,
                        mounted: mounted,
                      ),
                      onReviewUserBalloonTap: (UserModel? userModel) => onReviewUserBalloonTap(
                        userModel: userModel,
                      ),
                    );

                }

                /// SUBMITTED REVIEWS
                else {

                  final ReviewModel _reviewModel = reviews[index];

                  return FutureBuilder<bool>(
                      future: ReviewProtocols.readIsAgreed(
                        reviewID: _reviewModel.id,
                        flyerID: _reviewModel.flyerID,
                        bzID: widget.flyerModel?.bzID,
                      ),
                      initialData: false,
                      builder: (_, AsyncSnapshot<bool> snapshot){

                        final bool _isAlreadyAgreed = snapshot.data ?? false;

                        return ReviewViewBubble(
                          isSpecial: widget.highlightReviewID == _reviewModel.id,
                          flyerModel: widget.flyerModel,
                          pageWidth : widget.pageWidth,
                          reviewModel: _reviewModel,
                          isAgreed: _isAlreadyAgreed,

                          onReviewOptionsTap: () => onReviewOptions(
                            reviewModel: _reviewModel,
                            paginationController: _paginationController,
                            bzID: widget.flyerModel?.bzID,
                            mounted: mounted,
                          ),
                          onBzReplyOverReview: () => onBzReply(
                            reviewModel: _reviewModel,
                            paginationController: _paginationController,
                            bzID: widget.flyerModel?.bzID,
                            mounted: mounted,
                          ),
                          onReplyOptionsTap: () => onReplyOptions(
                            reviewModel: _reviewModel,
                            paginationController: _paginationController,
                            mounted: mounted,
                          ),
                          onReviewAgreeTap: () => onReviewAgree(
                            isAgreed: _isAlreadyAgreed,
                            reviewModel: _reviewModel,
                            paginationController: _paginationController,
                            mounted: mounted,
                          ),
                          onReviewUserBalloonTap: (UserModel? userModel) => onReviewUserBalloonTap(
                            userModel: userModel,
                          ),
                          onReplyBzBalloonTap: (BzModel? bzModel) => onReplyBzBalloonTap(
                            bzModel: bzModel,
                          ),
                        );

                      }
                  );

                }

              },
            );

          },
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
