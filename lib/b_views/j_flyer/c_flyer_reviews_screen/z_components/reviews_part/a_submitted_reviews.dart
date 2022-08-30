import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/aa_submitted_reviews_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_paginator.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/paginator_notifiers.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
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
  final TextEditingController _reviewTextController = TextEditingController();
  PaginatorNotifiers _paginatorNotifiers;
  ScrollController _controller;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  /*
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
   */
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _paginatorNotifiers = PaginatorNotifiers.initialize();
    _controller = ScrollController();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _reviewTextController.dispose();
    _paginatorNotifiers.dispose();
    _controller.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  FireQueryModel _createQueryModel(){
    return FireQueryModel(
      collRef: Fire.createSuperCollRef(
        aCollName: FireColl.flyers,
        bDocName: widget.flyerModel.id,
        cSubCollName: 'reviews',
      ),
      limit: 5,
      orderBy: const QueryOrderBy(
        fieldName: 'time',
        descending: true,
      ),
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('SubmittedReviews'),
      width: widget.pageWidth,
      height: widget.pageHeight,
      child: FireCollPaginator(
        scrollController: _controller,
        queryModel: _createQueryModel(),
        paginatorNotifiers: _paginatorNotifiers,
        addExtraMapsAtEnd: false,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          return ReviewsBuilder(
            appBarType: widget.appBarType,
            scrollController: _controller,
            pageHeight: widget.pageHeight,
            pageWidth: widget.pageWidth,
            flyerModel: widget.flyerModel,
            reviewTextController: _reviewTextController,
            reviewsMaps: maps,
            paginatorNotifiers: _paginatorNotifiers,
          );

        },
      ),
    );

  }
}
