import 'dart:io';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyer_deck.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/notes/note_banner_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class NoteBannerBaker extends StatefulWidget {

  const NoteBannerBaker({
    Key key
  }) : super(key: key);

  @override
  _NoteBannerBakerState createState() => _NoteBannerBakerState();
}

class _NoteBannerBakerState extends State<NoteBannerBaker> {
  // -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
  BzModel _bzModel;
  File _image;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

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
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    blog('fuck');
    // --------------------

    final double _bannerWidth = Bubble.clearWidth(context) - 80;
    final double _bannerHeight = NoteBannerBox.getBoxHeight(_bannerWidth);
    // final double _clearWidth = NoteBannerBox.getClearWidth(_bannerWidth);
    final double _clearHeight = NoteBannerBox.getClearHeight(_bannerWidth);

    // final List<SlideModel> _slides = _flyerModel == null ? [] : _flyerModel.slides;
    // _flyerModel.slides.sort((a,b) => b.slideIndex.compareTo(a.slideIndex));

    // --------------------
    return DashBoardLayout(
      pageTitle: 'Note Banner Baker',
      loading: _loading,
      listWidgets: <Widget>[

        // --------------------------------------

        /// FLYER TITLE
        Center(
          child: DreamBox(
            height: 30,
            width: _bannerWidth,
            verse: Verse.plain('Flyer'),
            verseCentered: false,
            icon: Iconz.xSmall,
            iconSizeFactor: 0.5,
            onTap: (){
              setState(() {
                _flyerModel = null;
              });
            },
          ),
        ),

        /// FLYER BANNER
        NoteBannerBox(
          width: _bannerWidth,
          color: Colorz.bloodTest,
          child:

          _flyerModel != null ?
          FlyerDeck(
            maxPossibleWidth: _bannerWidth,
            deckHeight: _clearHeight,
            flyerModel: _flyerModel,
            expansion: 0.5,
            minSlideHeightFactor: 0.85,
          )
              :
          DreamBox(
            width: _bannerWidth,
            height: _bannerHeight,
            icon: Iconz.addFlyer,
            bubble: false,
            iconColor: Colorz.white50,
            onTap: () async {

              final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
                context: context,
                screen: const SavedFlyersScreen(
                  selectionMode: true,
                ),
              );

              if (Mapper.checkCanLoopList(_selectedFlyers) == true){

                setState(() {
                  _flyerModel = _selectedFlyers.first;
                });

              }

            },
          ),
        ),

        const SizedBox(width: 10, height: 10,),

        // --------------------------------------

        /// BZ TITLE
        Center(
          child: DreamBox(
            height: 30,
            width: _bannerWidth,
            verse: Verse.plain('Business'),
            verseCentered: false,
            icon: Iconz.xSmall,
            iconSizeFactor: 0.5,
            onTap: (){
              setState(() {
                _bzModel = null;
              });
            },
          ),
        ),

        /// BZ BANNER
        NoteBannerBox(
          width: _bannerWidth,
          color: Colorz.bloodTest,
          child: Container(),
        ),

        const SizedBox(width: 10, height: 10,),

        // --------------------------------------

        /// IMAGE TITLE
        Center(
          child: DreamBox(
            height: 30,
            width: _bannerWidth,
            verse: Verse.plain('Image'),
            verseCentered: false,
            icon: Iconz.xSmall,
            iconSizeFactor: 0.5,
            onTap: (){
              setState(() {
                _image = null;
              });
            },
          ),
        ),

        /// IMAGE BANNER
        NoteBannerBox(
          width: _bannerWidth,
          color: Colorz.bloodTest,
          child:

          _image != null ?
          SuperImage(
            width: _bannerWidth,
            height: _bannerHeight,
            pic: _image,
            corners: NoteBannerBox.getCorners(
                context: context,
                boxWidth: _bannerWidth,
            ),
          )
              :
          DreamBox(
            width: _bannerWidth,
            height: _bannerHeight,
            icon: Iconz.phoneGallery,
            bubble: false,
            iconColor: Colorz.white50,
            onTap: () async {
              final FileModel _pickedFileModel = await Imagers.pickAndCropSingleImage(
                context: context,
                cropAfterPick: true,
                aspectRatio: NoteBannerBox.getAspectRatio(),
              );
              if (_pickedFileModel != null){
                setState(() {
                  _image = _pickedFileModel.file;
                });
              }
              },
          ),

        ),

        const Horizon(),

        // --------------------------------------

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
