import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/submitted_reviews_builder.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_paginator.dart';
import 'package:bldrs/e_db/fire/fire_models/query_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
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
  final ValueNotifier<List<Map<String, dynamic>>> _extraMapsAdded = ValueNotifier([]);
  ScrollController _controller;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
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
  @override
  void dispose() {
    _loading.dispose();
    _textController.dispose();
    _extraMapsAdded.dispose();
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
        extraMaps: _extraMapsAdded,
        addExtraMapsAtEnd: false,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

          return ReviewsBuilder(
            scrollController: _controller,
            pageHeight: widget.pageHeight,
            pageWidth: widget.pageWidth,
            flyerBoxWidth: widget.flyerBoxWidth,
            flyerModel: widget.flyerModel,
            textController: _textController,
            extraMapsAdded: _extraMapsAdded,
            reviewsMaps: maps,
          );

        },
      ),
    );

  }
}
