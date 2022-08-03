import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/c_review_bubble.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/xxx_new_review_creator_tree.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/x_flyer_controllers/reviews_controller.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SubmittedReviews extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SubmittedReviews({
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  State<SubmittedReviews> createState() => _SubmittedReviewsState();
/// --------------------------------------------------------------------------
}

class _SubmittedReviewsState extends State<SubmittedReviews> {
// -----------------------------------------------------------------------------
  final TextEditingController _textController = TextEditingController();
  final ValueNotifier<List<ReviewModel>> _reviews = ValueNotifier(<ReviewModel>[]);
  List<Map<String, dynamic>> _maps;
  ScrollController _controller;
  Map<String, dynamic> _startAfter;
  bool _canPaginate = true;
  bool _noMoreReviewsFound = false;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'RealCollPaginator',);
    }
  }
// -----------------------------------------------------------------------------
  static const double _paginationHeightLight = 0;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    // _maps = <Map<String, dynamic>>[];
    // _controller = ScrollController();
    //
    // _controller.addListener(() async {
    //
    //   final double _maxScroll = _controller.position.maxScrollExtent;
    //   final double _currentScroll = _controller.position.pixels;
    //
    //   // blogScrolling(
    //   //   max: _maxScroll,
    //   //   current: _currentScroll,
    //   // );
    //
    //   if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){
    //
    //     _canPaginate = false;
    //
    //     await _readMore();
    //
    //     _canPaginate = true;
    //
    //   }

    // });

  }
// -----------------------------------------------------------------------------
  void blogScrolling({
    @required double max,
    @required double current,
}) {

    // final double _max = Numeric.roundFractions(max, 1);
    // final double _current = Numeric.roundFractions(current, 1);
    //
    // final bool _shouldPaginate = RealCollPaginator.shouldPaginate(
    //   max: max,
    //   current: current,
    //   paginationHeight: _paginationHeightLight,
    //   canPaginate: _canPaginate,
    // );
    //
    // blog('SHOULD LOAD : (_max $_max - _current $_current) = ${max-current} : _shouldPaginate $_shouldPaginate');

  }
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading().then((_) async {
        // await _readMore();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _textController.dispose();
    _reviews.dispose();
      // _controller.dispose();

    super.dispose();

    /// tamam
  }
// -----------------------------------------------------------------------------
//   Future<void> _readMore() async {
//     _loading.value = true;
//
//     if (_noMoreReviewsFound == false){
//
//       blog('should read more : startAfter is $_startAfter');
//
//       final List<Map<String, dynamic>> _nextMaps = await Real.readColl(
//         context: context,
//         nodePath: ReviewRealOps.createRealPath(widget.flyerModel.id),
//         startAfter: _startAfter,
//         limit: 3,
//         limitToFirst: false,
//         realOrderBy: const RealPaginator(
//           orderByField: 'time',
//           // keyField: 'userID',
//         ),
//         // realOrderBy:
//       );
//
//       if (Mapper.checkCanLoopList(_nextMaps) == true){
//
//         final List<Map<String, dynamic>> _combinedMaps = <Map<String, dynamic>>[..._maps, ..._nextMaps];
//
//         // if (Mapper.checkMapsListsAreIdentical(maps1: _maps, maps2: _combinedMaps) == false){
//           _maps = _combinedMaps;
//           _startAfter = _maps.last;
//           final List<ReviewModel> _deciphered = ReviewModel.decipherReviews(maps: _maps, fromJSON: true);
//           _reviews.value = _deciphered;
//           // _reviews.value = ReviewModel.sortReviews(
//           //   reviews: _deciphered,
//           // );
//
//         // }
//
//
//
//       }
//
//       else {
//         _noMoreReviewsFound = true;
//       }
//
//     }
//     else {
//       blog('NO MORE REVIEWS AFTER THIS ID $_startAfter');
//     }
//
//     _loading.value = false;
//   }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FirebaseAnimatedList(
      query: Real.createQuery(
        ref: Real.getRef().child('reviews'),
        realPaginator: const RealPaginator(orderByField: 'time'),
        startAfter: _startAfter,
        limit: 3,
        // limitToFirst: false,
      ),

      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation, int i){

        final List<Map<String, dynamic>> _maps = Mapper.getMapsFromInternalHashLinkedMapObjectObject(
            internalHashLinkedMapObjectObject: snapshot.value,
        );

        final List<ReviewModel> _reviews = ReviewModel.decipherReviews(
          maps: _maps,
          fromJSON: true,
        );

        ReviewModel.blogReviews(reviews: _reviews);

        return SizedBox(
          key: const ValueKey<String>('SubmittedReviews'),
          width: widget.pageWidth,
          height: widget.pageHeight,
          child: ListView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              bottom: Ratioz.horizon,
            ),
            itemCount: _reviews.length + 1,
            itemBuilder: (_, int index){

              if (index == 0 || snapshot.value == null){
                return NewReviewCreatorTree(
                  pageWidth: widget.pageWidth,
                  flyerBoxWidth: widget.flyerBoxWidth,
                  pageHeight: widget.pageHeight,
                  reviewTextController: _textController,
                  onEditReview: (){blog('SHOULD EDIT REVIEW');},
                  onSubmitReview: () => onReviewFlyer(
                    context: context,
                    flyerModel: widget.flyerModel,
                    text: _textController.text,
                    // reviews: null,
                  ),
                );
              }

              else {

                final ReviewModel _review = _reviews[index - 1];

                final bool _isLastReview = ReviewModel.checkReviewsAreIdentical(
                  review1: _review,
                  review2: ReviewModel.decipherReview(map: _startAfter,fromJSON: true),
                );

                return ReviewBubble(
                  pageWidth : widget.pageWidth,
                  color: _isLastReview == true ? Colorz.bloodTest : Colorz.blue80,
                  flyerBoxWidth: widget.flyerBoxWidth,
                  reviewModel: _reviews[index - 1],
                  // specialReview: true,
                );

              }


            },
          ),
        );


      },
    );

    return SizedBox(
      key: const ValueKey<String>('SubmittedReviews'),
      width: widget.pageWidth,
      height: widget.pageHeight,
      child: ValueListenableBuilder(
          valueListenable: _reviews,
          child: NewReviewCreatorTree(
            pageWidth: widget.pageWidth,
            flyerBoxWidth: widget.flyerBoxWidth,
            pageHeight: widget.pageHeight,
            reviewTextController: _textController,
            onEditReview: (){blog('SHOULD EDIT REVIEW');},
            onSubmitReview: () => onReviewFlyer(
              context: context,
              flyerModel: widget.flyerModel,
              text: _textController.text,
              // reviews: _reviews,
            ),
          ),
          builder: (_, List<ReviewModel> reviews, Widget newReviewCreator){

            return ListView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: Ratioz.horizon,
              ),
              itemCount: reviews.length + 1,
              itemBuilder: (_, int index){

                if (index == 0){
                  return newReviewCreator;
                }

                else {

                  final ReviewModel _review = reviews[index - 1];

                  final bool _isLastReview = ReviewModel.checkReviewsAreIdentical(
                    review1: _review,
                    review2: ReviewModel.decipherReview(map: _startAfter,fromJSON: true),
                  );

                  return ReviewBubble(
                    pageWidth : widget.pageWidth,
                    color: _isLastReview == true ? Colorz.bloodTest : Colorz.blue80,
                    flyerBoxWidth: widget.flyerBoxWidth,
                    reviewModel: reviews[index - 1],
                    // specialReview: true,
                  );

                }


              },
            );

          }),

    );

  }
}
