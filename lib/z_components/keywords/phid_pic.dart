import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
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
  PicModel? _picModel;
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
      _isInit = false; // good

      asyncInSync(() async {

        final PicModel? _pic = await PicProtocols.fetchPic(StoragePath.phids_phid(widget.phid));

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
      iconSizeFactor: Phider.checkIsPhid(widget.phid) ? 1 : 0.7,
      bubble: false,
      loading: _picModel == null && _loading == true,
      icon: _picModel?.bytes ?? Iconz.circleDot,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
