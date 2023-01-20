
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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

        /// FUCK

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
  Future<void> blogPermission({
    @required Permission permission,
    @required BuildContext context,
  }) async {

    String _blog;

    if (permission == null){
      _blog = 'permission is null';
    }
    else {

      final PermissionStatus _status = await permission.status;

      final String _statusName = _status.name;
      final int _statusIndex = _status.index;

      final bool _statusIsDenied = _status.isDenied;
      final bool _perDenied = await permission.isDenied;

      final bool _statusIsGranted = _status.isGranted;
      final bool _perIsGranted = await permission.isGranted;

      final bool _statusIsRestricted = _status.isRestricted;
      final bool _perIsRestricted = await permission.isRestricted;

      final bool _statusIsLimited = _status.isLimited;
      final bool _perIsLimited = await permission.isLimited;

      final bool _perIsPermanentlyDenied = await permission.isPermanentlyDenied;
      final bool _perShouldShowRequestRationale = await permission.shouldShowRequestRationale;

      _blog =
          '[ toString() ]         : ${permission.toString()}\n'
          '[ name ]                : $_statusName\n'
          '[ index ]                : $_statusIndex\n'
          '\n'
          '[ Granted ]            : $_statusIsGranted : $_perIsGranted\n'
          '[ Denied ]              : $_statusIsDenied : $_perDenied\n'
          '\n'
          '[ Restricted ]         : $_statusIsRestricted : $_perIsRestricted\n'
          '[ Limited ]              : $_statusIsLimited : $_perIsLimited\n'
          '\n'
          '[ Permanently denied ] : $_perIsPermanentlyDenied\n'
          '\n'
          '[ shouldRationale ]       : $_perShouldShowRequestRationale\n'
          ;

    }

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain(permission?.toString()),
      bodyVerse: Verse(
        translate: false,
        text: _blog,
      ),
      bodyCentered: false,
    );

  }
  // --------------------
  Future<void> requestPermission({
    @required Permission permission,
    @required BuildContext context,
  }) async {

      // final PermissionStatus _status =
      await permission.request();

      await blogPermission(
        context: context,
        permission : permission,
      );

    }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: widget.permission.status,
      builder: (_, AsyncSnapshot<PermissionStatus> snap){

        final PermissionStatus _status = snap.data;

        return DreamBox(
          height: 50,
          width: 300,
          verse: Verse.plain(widget.text),
          icon: widget.icon,
          iconSizeFactor: 0.7,
          verseCentered: false,
          iconColor: _status?.isGranted == true ? Colorz.green255 : Colorz.white255,
          onTap: () => blogPermission(
            permission: widget.permission,
            context: context,
          ),
          onLongTap: () => requestPermission(
            permission: widget.permission,
            context: context,
          ),
        );

      },
    );
  }
  // -----------------------------------------------------------------------------
}
