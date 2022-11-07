import 'dart:ui' as ui;

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class StaticFlyerTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StaticFlyerTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StaticFlyerTestScreenState createState() => _StaticFlyerTestScreenState();
  /// --------------------------------------------------------------------------
}

class _StaticFlyerTestScreenState extends State<StaticFlyerTestScreen> {
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

        // 5VOZyFGDaY3WHfFKzzkH

        const String flyerID = 'tuKZixD2pEazLtyyALOV';

        _flyerModel = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: flyerID,
        );

        if (_flyerModel != null){

          final List<SlideModel> _slidesWithPaths = <SlideModel>[];
          for (int i = 0; i < _flyerModel.slides.length; i++){

            SlideModel _slide = _flyerModel.slides[i];
            final String _path = await StorageRef.getPathByURL(_slide.picPath);
            // await PicProtocols.downloadPic(_path);
            final ui.Image _theImage = await PicProtocols.fetchPicUiImage(_path);
            blog('the fucking shit is : ${_theImage.runtimeType}');
            _slide = _slide.copyWith(
              uiImage: _theImage,
            );

            _slidesWithPaths.add(_slide);

          }

          setState(() {
            _flyerModel = _flyerModel.copyWith(
              slides: _slidesWithPaths,
            );
          });

        }


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
  FlyerModel _flyerModel;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // _flyerModel?.blogFlyer(invoker: 'flyerTest');
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        if (_flyerModel != null)
          Flyer(
            key: const ValueKey<String>('FlyerHero'),
            flyerBoxWidth: 250,
            screenName: 'FlyerTestScreen',
            flyerModel: _flyerModel,
        ),

        const SizedBox(
          height: 20,
          width: 20,
        ),

        // if (_flyerModel != null)
        //   Stack(
        //     children: <Widget>[
        //
        //       // StaticHeader(
        //       //     flyerBoxWidth: Scale.superScreenWidth(context),
        //       //     bzModel: _bzModel,
        //       //     authorID: _flyerModel.id,
        //       //     flyerShowsAuthor: true
        //       // ),
        //
        //       Opacity(
        //         opacity: 0.5,
        //         child: HeaderTemplate(
        //           flyerBoxWidth: Scale.superScreenWidth(context),
        //
        //         ),
        //       ),
        //
        //     ],
        //   ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
