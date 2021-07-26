import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/sliders.dart' show SwipeDirection, Sliders;
import 'package:bldrs/controllers/drafters/imagers.dart' ;
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/x_x_flyer_on_map.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/buttons/slides_counter.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/flyer/editor/editorPanel.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_pages.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';

class FlyerEditorScreen extends StatefulWidget {
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  FlyerEditorScreen({
    @required this.bzModel,
    @required this.firstTimer,
    this.flyerModel,
  });

  @override
  _FlyerEditorScreenState createState() => _FlyerEditorScreenState();
}

class _FlyerEditorScreenState extends State<FlyerEditorScreen> with AutomaticKeepAliveClientMixin{
  /// to keep out of screen objects alive when using [with AutomaticKeepAliveClientMixin]
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  FlyerModel _flyer;
  SuperFlyer _superFlyer;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    /// by defining _flyer and its conditions,, we can use _flyer anywhere
    // _superFlyer = widget.firstTimer ? SuperFlyer;
    _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();

    super.initState();
  }
// -----------------------------------------------------------------------------
  FlyerModel _createTempEmptyFlyer(){

    AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, superUserID());
    TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);


    return new FlyerModel(
      flyerID : SuperFlyer.draftID,
      // -------------------------
      flyerType : FlyerTypeClass.concludeFlyerType(widget.bzModel.bzType),
      flyerState : FlyerState.Draft,
      keywords : _superFlyer?.keywords,
      flyerShowsAuthor : true,
      flyerURL : '...',
      flyerZone: _countryPro.currentZone,
      // -------------------------
      tinyAuthor : _tinyAuthor,
      tinyBz : TinyBz.getTinyBzFromBzModel(widget.bzModel),
      // -------------------------
      publishTime : DateTime.now(),
      flyerPosition : null,
      // -------------------------
      ankhIsOn : false,
      // -------------------------
      slides : new List(),
      // -------------------------
      flyerIsBanned: false,
      deletionTime: null,
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    double _screenWidth = Scale.superScreenWidth(context);
    double _flyerZoneHeight = Scale.superScreenHeightWithoutSafeArea(context) - Ratioz.appBarSmallHeight - (Ratioz.appBarMargin * 3);
    double _flyerSizeFactor = Scale.superFlyerSizeFactorByHeight(context, _flyerZoneHeight);
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _panelWidth = _screenWidth - _flyerZoneWidth - (Ratioz.appBarMargin * 3);
    AuthorModel _author = widget.firstTimer ?
    AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, superUserID()) :
    AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, _flyer.tinyAuthor.userID);
    // BoxFit _currentPicFit = _superFlyer?.boxesFits?.length == 0 ? null : _superFlyer?.boxesFits[_superFlyer?.currentSlideIndex];

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        SlidesCounter(),

        Expander(),

        PublishButton(
          firstTimer: widget.firstTimer,
          loading: false, /// TASK : add loading to superFlyer
          onTap: (){

            //widget.firstTimer ? _superFlyer.createNewFlyer : _superFlyer.updateExistingFlyer,

            print('fuck the fucking null');

          }
        ),

      ],

      layoutWidget: Column(
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[

          Stratosphere(),

          /// FLYER & PANEL ZONES
          FinalFlyer(
            flyerZoneWidth: _flyerZoneWidth,
            flyerModel: _flyer,
            tinyFlyer: null,
            isDraft: true,
            initialSlideIndex: 0,
          ),

        ],
      ),
    );
  }
}
