import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/x_reviews_controller.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/aa_submitted_reviews_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/e_back_end/x_queries/reviews_queries.dart';
import 'package:bldrs/e_back_end/z_helpers/pagination_controller.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class SubmittedReviews extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SubmittedReviews({
    @required this.pageWidth,
    @required this.pageHeight,
    @required this.flyerModel,
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double pageHeight;
  final FlyerModel flyerModel;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  State<SubmittedReviews> createState() => _SubmittedReviewsState();
  /// --------------------------------------------------------------------------
}

class _SubmittedReviewsState extends State<SubmittedReviews> {
  // -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
  // --------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  final TextEditingController _reviewTextController = TextEditingController();
  PaginationController _paginationController;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _paginationController = PaginationController.initialize(
      addExtraMapsAtEnd: false,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading(setTo: true).then((_) async {
        // -----------------------------
          await loadReviewEditorLastSession(
            context: context,
            reviewController: _reviewTextController,
            flyerID: widget.flyerModel.id,
          );
        // -----------------------------
        // if (widget.validateOnStartup == true){
        //   Formers.validateForm(_formKey);
        // }
        // -----------------------------
        _createStateListeners();
        // -------------------------------
        await _triggerLoading(setTo: false);
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _reviewTextController.dispose();
    _paginationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _createStateListeners(){
    _reviewTextController.addListener(() async {

      await saveReviewEditorSession(
        flyerID: widget.flyerModel.id,
        reviewController: _reviewTextController,
      );

    });
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('SubmittedReviews'),
      width: widget.pageWidth,
      height: widget.pageHeight,
      child: FireCollPaginator(
        scrollController: _scrollController,
        paginationQuery: reviewsPaginationQuery(
          flyerID: widget.flyerModel.id,
        ),
        streamQuery: reviewsStreamQuery(
          context: context,
          flyerID: widget.flyerModel.id,
        ),
        paginationController: _paginationController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          return ReviewsBuilder(
            appBarType: widget.appBarType,
            scrollController: _scrollController,
            pageHeight: widget.pageHeight,
            pageWidth: widget.pageWidth,
            flyerModel: widget.flyerModel,
            reviewTextController: _reviewTextController,
            reviewsMaps: maps,
            paginatorController: _paginationController,
            globalKey: globalKey,
          );

        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
