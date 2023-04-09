import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionButton extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const PermissionButton({
    @required this.permission,
    @required this.icon,
    @required this.text,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Permission permission;
  final String icon;
  final String text;
  // -----------------------------------------------------------------------------
  @override
  _PermissionButtonState createState() => _PermissionButtonState();
  /// --------------------------------------------------------------------------
}

class _PermissionButtonState extends State<PermissionButton> {
  // -----------------------------------------------------------------------------
  PermissionStatus _status;
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

        await _checkSetSPermissionStatus();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
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
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _checkSetSPermissionStatus() async {

    final PermissionStatus _stat = await widget.permission.status;

    setState(() {
      _status = _stat;
    });


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _requestPermit({
    @required Permission permission,
    @required BuildContext context,
  }) async {

      final bool _granted = await Permit.requestPermission(
        context: context,
        permission: permission,
      );

      if (_granted == true){
        await _checkSetSPermissionStatus();
      }

    }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _height = 40;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          BldrsBox(
            height: _height,
            width: 250,
            verse: Verse.plain(widget.text),
            icon: widget.icon,
            iconSizeFactor: 0.7,
            verseCentered: false,
            iconColor: _status?.isGranted == true ? Colorz.green255 : Colorz.white255,
            onTap: () => Permit.blogPermission(
              permission: widget.permission,
            ),
          ),

          BldrsBox(
            height: _height,
            width: _height,
            icon: _status.isGranted == true ? Iconz.check : Iconz.xSmall,
            iconSizeFactor: 0.6,
            onTap: () => _requestPermit(
              permission: widget.permission,
              context: context,
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
