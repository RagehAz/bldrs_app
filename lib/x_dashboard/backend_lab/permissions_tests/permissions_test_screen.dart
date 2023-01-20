import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/x_dashboard/backend_lab/permissions_tests/permission_button.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {

  const PermissionScreen({
    Key key
  }) : super(key: key);

  List<dynamic> list(){

    return [
      {
        'permission': Permission.calendar,
        'name': 'calendar',
        'icon': Iconz.calendar,
      },
      {
        'permission': Permission.camera,
        'name': 'camera',
        'icon': Iconz.camera,
      },
      {
        'permission': Permission.contacts,
        'name': 'contacts',
        'icon': Iconz.phone,
      },
      {
        'permission': Permission.location,
        'name': 'location',
        'icon': Iconz.locationPinBlack,
      },
      {
        'permission': Permission.locationAlways,
        'name': 'locationAlways',
        'icon': Iconz.locationPin,
      },
      {
        'permission': Permission.locationWhenInUse,
        'name': 'locationWhenInUse',
        'icon': Iconz.flyerPin,
      },
      {
        'permission': Permission.mediaLibrary,
        'name': 'mediaLibrary',
        'icon': Iconz.phoneGallery,
      },
      {
        'permission': Permission.microphone,
        'name': 'microphone',
        'icon': Iconz.circleDot,
      },
      {
        'permission': Permission.phone,
        'name': 'phone',
        'icon': Iconz.mobilePhone,
      },
      {
        'permission': Permission.photos,
        'name': 'photos',
        'icon': Iconz.gallery,
      },
      {
        'permission': Permission.photosAddOnly,
        'name': 'photosAddOnly',
        'icon': Iconz.gallery,
      },
      {
        'permission': Permission.reminders,
        'name': 'reminders',
        'icon': Iconz.calendar,
      },
      {
        'permission': Permission.sensors,
        'name': 'sensors',
        'icon': Iconz.target,
      },
      {
        'permission': Permission.sms,
        'name': 'sms',
        'icon': Iconz.balloonSpeaking,
      },
      {
        'permission': Permission.speech,
        'name': 'speech',
        'icon': Iconz.normalUser,
      },
      {
        'permission': Permission.storage,
        'name': 'storage',
        'icon': Iconz.form,
      },
      {
        'permission': Permission.ignoreBatteryOptimizations,
        'name': 'ignoreBatteryOptimizations',
        'icon': Icons.battery_0_bar_sharp,
      },
      {
        'permission': Permission.notification,
        'name': 'notification',
        'icon': Iconz.notification,
      },
      {
        'permission': Permission.accessMediaLocation,
        'name': 'accessMediaLocation',
        'icon': Icons.mediation,
      },
      {
        'permission': Permission.activityRecognition,
        'name': 'activityRecognition',
        'icon': Icons.running_with_errors,
      },
      {
        'permission': Permission.unknown,
        'name': 'unknown',
        'icon': Icons.question_mark,
      },
      {
        'permission': Permission.bluetooth,
        'name': 'bluetooth',
        'icon' : Icons.bluetooth,
      },
    ];

  }

  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      listWidgets: <Widget>[

        SuperVerse(
          verse: Verse.plain('Note :\n'
              '- Single tap to Check permission\n'
              '- Long tap to Request permission'),
          italic: true,
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          weight: VerseWeight.thin,
          color: Colorz.yellow200,
          maxLines: 5,
          centered: false,
        ),

        ...List.generate(list().length, (index){

          final Map<String, dynamic> _map = list()[index];

          return PermissionButton(
            text: _map['name'],
            icon: _map['icon'],
            permission: _map['permission'],
          );

        }),

      ],
    );
    // --------------------
  }


}

// class PermissionsTestScreen extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const PermissionsTestScreen({
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   _TheStatefulScreenState createState() => _TheStatefulScreenState();
//   /// --------------------------------------------------------------------------
// }
//
// class _TheStatefulScreenState extends State<PermissionsTestScreen> {
//   // -----------------------------------------------------------------------------
//   /// --- LOADING
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({@required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit && mounted) {
//
//       _triggerLoading(setTo: true).then((_) async {
//
//         /// FUCK
//
//         await _triggerLoading(setTo: false);
//       });
//
//       _isInit = false;
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   /*
//   @override
//   void didUpdateWidget(TheStatefulScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.thing != widget.thing) {
//       unawaited(_doStuff());
//     }
//   }
//    */
//   // --------------------
//   @override
//   void dispose() {
//     _loading.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   Future<void> blogPermission(Permission permission) async {
//
//     String _blog;
//
//     if (permission == null){
//       _blog = 'permission is null';
//     }
//     else {
//
//       final PermissionStatus _status = await permission.status;
//
//       final String _statusName = _status.name;
//       final int _statusIndex = _status.index;
//
//       final bool _statusIsDenied = _status.isDenied;
//       final bool _perDenied = await permission.isDenied;
//
//       final bool _statusIsGranted = _status.isGranted;
//       final bool _perIsGranted = await permission.isGranted;
//
//       final bool _statusIsRestricted = _status.isRestricted;
//       final bool _perIsRestricted = await permission.isRestricted;
//
//       final bool _statusIsLimited = _status.isLimited;
//       final bool _perIsLimited = await permission.isLimited;
//
//       final bool _perIsPermanentlyDenied = await permission.isPermanentlyDenied;
//       final bool _perShouldShowRequestRationale = await permission.shouldShowRequestRationale;
//
//       _blog =
//           '[ toString() ]         : ${permission.toString()}\n'
//           '[ name ]                : $_statusName\n'
//           '[ index ]                : $_statusIndex\n'
//           '\n'
//           '[ Granted ]            : $_statusIsGranted : $_perIsGranted\n'
//           '[ Denied ]              : $_statusIsDenied : $_perDenied\n'
//           '\n'
//           '[ Restricted ]         : $_statusIsRestricted : $_perIsRestricted\n'
//           '[ Limited ]              : $_statusIsLimited : $_perIsLimited\n'
//           '\n'
//           '[ Permanently denied ] : $_perIsPermanentlyDenied\n'
//           '\n'
//           '[ shouldRationale ]       : $_perShouldShowRequestRationale\n'
//           ;
//
//     }
//
//     await CenterDialog.showCenterDialog(
//       context: context,
//       titleVerse: Verse.plain(permission?.toString()),
//       bodyVerse: Verse(
//         translate: false,
//         text: _blog,
//       ),
//       bodyCentered: false,
//     );
//
//   }
//   // --------------------
//   Future<void> requestPermission(Permission permission) async {
//     final PermissionStatus _status = await permission.request();
//     blog(_status);
//   }
//   // -----------------------------------------------------------------------------
//
//   // -----------------------------------------------------------------------------
// }
