import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/c_review_bubble.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/xxx_new_review_creator_tree.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/x_flyer_controllers/reviews_controller.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/ops/review_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
  final ValueNotifier<List<ReviewModel>> _reviews = ValueNotifier(<ReviewModel>[]);
  List<Map<String, dynamic>> _maps;
  ScrollController _controller;
  Map<String, dynamic> _startAfter;
  bool _canPaginate = true;
  final TextEditingController _textController = TextEditingController();
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
  static const double _paginationHeightLight = Ratioz.horizon * 1;

  @override
  void initState() {
    super.initState();

    _maps = <Map<String, dynamic>>[];
    _controller = ScrollController();

    _controller.addListener(() async {

      final double _maxScroll = _controller.position.maxScrollExtent;
      final double _currentScroll = _controller.position.pixels;

      // blog('inn : scroll is at : $_currentScroll');

      if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){

        _canPaginate = false;

        blogScrolling(
          max: _maxScroll,
          current: _currentScroll,
        );

        // await _readMore();

        _canPaginate = true;

      }

    });

  }
// -----------------------------------------------------------------------------
  void blogScrolling({
    @required double max,
    @required double current,
}){

    final double _max = Numeric.roundFractions(max, 1);
    final double _current = Numeric.roundFractions(current, 1);

    blog('SHOULD LOAD : (_max $_max - _current $_current) = ${max-current} : _paginationHeightLight $_paginationHeightLight');

  }

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading().then((_) async {
        await _readMore();
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
      _controller.dispose();

    super.dispose();

    /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _readMore() async {
    _loading.value = true;

    blog('should read more : startAfter is $_startAfter');

    final List<Map<String, dynamic>> _nextMaps = await Real.readColl(
      context: context,
      nodePath: ReviewRealOps.createRealPath(widget.flyerModel.id),
      startAfter: _startAfter,
      limit: 5,
      // realOrderBy: RealOrderBy.value,
      limitToFirst: false,
      // realOrderBy:
    );

    if (Mapper.checkCanLoopList(_nextMaps) == true){
      _maps = <Map<String, dynamic>>[..._maps, ..._nextMaps];
      _startAfter = _maps.last;

      final List<ReviewModel> _deciphered = ReviewModel.decipherReviews(maps: _maps, fromJSON: true);
      _reviews.value = ReviewModel.sortReviews(
        reviews: _deciphered,
      );
    }

    _loading.value = false;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('SubmittedReviews'),
      width: widget.pageWidth,
      height: widget.pageHeight,
      child: ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool isLoading, Widget child){

          // /// LOADING
          // if (isLoading == true){
          //   return const Center(
          //     child: Loading(loading: true,),
          //   );
          // }
          //
          // /// FINISHED LOADING
          // else {

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

            return ValueListenableBuilder(
                valueListenable: _reviews,
                builder: (_, List<ReviewModel> reviews, Widget child){

              return ListView.builder(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  bottom: Ratioz.horizon,
                ),
                itemCount: reviews.length + 1,
                itemBuilder: (_, int index){

                  if (index == 0){
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
                      ),
                    );
                  }

                  else {

                    return ReviewBubble(
                      pageWidth : widget.pageWidth,
                      flyerBoxWidth: widget.flyerBoxWidth,
                      reviewModel: reviews[index - 1],
                      // specialReview: true,
                    );

                  }


                },
              );

            });

          }

        // },
      ),


      // child: RealCollPaginator(
      //   scrollController: reviewPageVerticalController,
      //   // realOrderBy: RealOrderBy.child,
      //   nodePath: ReviewRealOps.createRealPath(flyerID),
      //   builder: (_, List<Map<String, dynamic>> maps, bool isLoading){
      //
      //
      //     // }
      //
      //   },
      // ),
    );

  }
}
