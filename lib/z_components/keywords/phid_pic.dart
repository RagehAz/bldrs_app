import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/c_keywords/keyworder.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:flutter/material.dart';

class PhidPic extends StatefulWidget {
  // --------------------------------------------------------------------------
  const PhidPic({
    required this.phid,
    required this.size,
    this.corners,
    super.key
  });
  // --------------------
  final String? phid;
  final double size;
  final dynamic corners;
  // --------------------
  @override
  _PhidPicState createState() => _PhidPicState();
  // --------------------------------------------------------------------------
}

class _PhidPicState extends State<PhidPic> {
  // -----------------------------------------------------------------------------
  bool _loading = true;
  MediaModel? _picModel;
  String? _rootIcon;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _rootIcon = FlyerTyper.getRootIcon(widget.phid);

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        MediaModel? _pic;


        if (_rootIcon == null){
          _pic = await PicProtocols.fetchPic(StoragePath.phids_phid(widget.phid));
        }


        if (mounted == true){
          setState(() {
            _loading = false;
            _picModel = _pic;
          });
        }

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
      height: widget.size,
      width: widget.size,
      corners: widget.corners,
      color: Colorz.white20,
      iconSizeFactor: Keyworder.checkIsPhid(widget.phid) ? 1 : 0.7,
      bubble: false,
      loading: _picModel == null && _loading == true,
      icon: _rootIcon ?? _picModel?.bytes ?? Iconz.circleDot,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
