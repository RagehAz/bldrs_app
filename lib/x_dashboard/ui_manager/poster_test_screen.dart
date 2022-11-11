import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/a_static_flyer.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/poster/structure/a_note_switcher.dart';
import 'package:bldrs/b_views/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class PosterTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PosterTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TheStatefulScreenState createState() => _TheStatefulScreenState();
/// --------------------------------------------------------------------------
}

class _TheStatefulScreenState extends State<PosterTestScreen> {
  // -----------------------------------------------------------------------------
  FlyerModel _flyer;
  BzModel _bz;
  Uint8List _posterBytes;
  PicModel _posterPicModel;
  final ScreenshotController _controller = ScreenshotController();
  final GlobalKey globalKey = GlobalKey();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: 'tuKZixD2pEazLtyyALOV',
        );

        _flyerModel = await FlyerProtocols.imagifySlides(_flyerModel);

        final BzModel _bzModel = await BzProtocols.fetch(
          context: context,
          bzID: _flyerModel.bzID,
        );

        setState(() {
          _flyer = _flyerModel;
          _bz = _bzModel;
        });

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
    // --------------------

    final double _posterWidth = BldrsAppBar.width(context);
    final double _posterHeight = NotePosterBox.getBoxHeight(_posterWidth);

    return DashBoardLayout(
      loading: _loading,
      appBarWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          icon: Iconz.xSmall,
          onTap: () {
            setState(() {
              _posterBytes = null;
            });
          },
        ),

        /// TREE-LESS CAPTURE
        AppBarButton(
          verse: Verse.plain('Treeless shot'),
          isDeactivated: _flyer == null,
          onTap: () async {

            await _triggerLoading(setTo: true);

            final BuildContext _context = BldrsAppStarter.navigatorKey.currentContext;

            final Uint8List _bytes = await _controller.captureFromWidget(
              Material(
                type: MaterialType.transparency,
                child: ChangeNotifierProvider(
                  create: (_) => PhraseProvider(),
                  lazy: false,
                  child: PosterSwitcher(
                    posterType: PosterType.flyer,
                    width: _posterWidth,
                    model: _flyer,
                    modelHelper: _bz,
                  ),
                ),
              ),
              context: _context,
              pixelRatio: MediaQuery.of(_context).devicePixelRatio,
              delay: const Duration(milliseconds: 200),
            );

            final PicModel _picModel = PicModel(
              path: 'flyers/{flyerID}/poster',
              bytes: _bytes,
              meta: PicMetaModel(
                ownersIDs: ['{ownerID}'],
                dimensions: await Dimensions.superDimensions(_bytes),
              ),
            );

            setState(() {
              _posterBytes = _bytes;
              _posterPicModel = _picModel;
            });

            await _triggerLoading(setTo: false);

          },
        ),

        /// TREE CAPTURE
        AppBarButton(
          verse: Verse.plain('Tree shot'),
          isDeactivated: _flyer == null,
          onTap: () async {

            final Uint8List _bytes = await _controller.capture(
              pixelRatio: MediaQuery.of(context).devicePixelRatio,
              delay: const Duration(milliseconds: 200),
            );

            setState(() {
              _posterBytes = _bytes;
            });

          },
        ),

        /// KEY SHOT
        AppBarButton(
          verse: Verse.plain('Key shot'),
          isDeactivated: _flyer == null,
          onTap: () async {

            final RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
            final ui.Image image = await boundary.toImage();
            final Uint8List _bytes = await Floaters.getUint8ListFromUiImage(image);
            // var byteData = await image.toByteData(format: ImageByteFormat.png);
            // var pngBytes = byteData.buffer.asUint8List();
            // print(pngBytes);

            setState(() {
              _posterBytes = _bytes;
            });

          },
        ),

      ],
      listWidgets: <Widget>[

        StaticFlyer(
          flyerModel: _flyer,
          flyerBoxWidth: 150,
          bzModel: _bz,
          flyerShadowIsOn: true,
        ),

        /// POSTER WIDGET TITLE
        SuperVerse(
          verse: Verse.plain('Poster Widget'),
          centered: false,
          margin: 10,
          italic: true,
        ),

        /// POSTER WIDGET
        Container(
          width: Scale.screenWidth(context),
          alignment: Alignment.center,
          child: Screenshot(
            controller: _controller,
            child: RepaintBoundary(
              key: globalKey,
              child: PosterSwitcher(
                width: BldrsAppBar.width(context),
                posterType: PosterType.flyer,
                model: _flyer,
                modelHelper: _bz,
              ),
            ),
          ),
        ),

        /// POSTER BYTES TITLE
        SuperVerse(
          verse: Verse.plain('Poster bytes'),
          centered: false,
          margin: 10,
          italic: true,
        ),

        /// POSTER BYTES
        Container(
          width: Scale.screenWidth(context),
          alignment: Alignment.center,
          child: ValueListenableBuilder(
            valueListenable: _loading,
            builder: (_, bool loading, Widget child){

              return SuperImage(
                width: _posterWidth,
                height: _posterHeight,
                pic: _posterBytes,
                backgroundColor: Colorz.white10,
                loading: loading,
              );

            },
          ),
        ),

        /// POSTER DIMENSIONS
        if (_posterPicModel != null)
        DataStrip(
            dataKey: 'Dimensions',
            dataValue: _posterPicModel.meta.dimensions.toString(),
        ),

        /// POSTER BOX ASPECT RATIO
        if (_posterPicModel != null)
          DataStrip(
            dataKey: 'Box AspectRatio',
            dataValue: Numeric.roundFractions(_posterPicModel.meta.dimensions.getAspectRatio(), 4),
          ),
        // StaticFlyer(
        //   flyerModel: _flyer,
        //   bzModel: _bz,
        //   flyerBoxWidth: _clearWidth,
        //   flyerShadowIsOn: true,
        // ),

        const Horizon(),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
