import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip_with_headline.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DeviceInfoScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
/// --------------------------------------------------------------------------
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  // -----------------------------------------------------------------------------
  PackageInfo _packageInfo;
  DeviceInfoPlugin _deviceInfoPlugin;
  // --------------------
  BaseDeviceInfo _basicDeviceInfo;
  AndroidDeviceInfo _androidInfo;
  // WebBrowserInfo _webInfo;
  IosDeviceInfo _iosInfo;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _deviceInfoPlugin = DeviceInfoPlugin();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {


        final PackageInfo _info = await PackageInfo.fromPlatform();

        final BaseDeviceInfo basicInfo = await _deviceInfoPlugin.deviceInfo;

        IosDeviceInfo iosInfo;
        if (DeviceChecker.deviceIsIOS() == true){
          iosInfo = await _deviceInfoPlugin.iosInfo;
        }

        AndroidDeviceInfo androidInfo;
        if  (DeviceChecker.deviceIsAndroid() == true){
          androidInfo = await _deviceInfoPlugin.androidInfo;
        }

        // if (kIsWeb) {
        //   deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
        //   // final WebBrowserInfo webBrowserInfo = await _deviceInfoPlugin.webBrowserInfo;
        // }

        setState(() {
          _packageInfo = _info;
          _basicDeviceInfo = basicInfo;
          _androidInfo = androidInfo;
          _iosInfo = iosInfo;
          // _webInfo = webBrowserInfo;
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
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        /// BASIC DEVICE INFO
        SuperVerse(verse: Verse.plain('BASIC DEVICE INFO'), size: 4, labelColor: Colorz.white50,),
        /// BASIC DEVICE INFO
        DataStripWithHeadline(dataKey: 'Basic device info', dataValue: _basicDeviceInfo?.toString(),),

        const SeparatorLine(),

        /// ANDROID INFO
        SuperVerse(verse: Verse.plain('ANDROID DEVICE INFO'), size: 4, labelColor: Colorz.white50,),
        DataStripWithHeadline(dataKey: '_androidInfo.board', dataValue: _androidInfo?.board),
        DataStripWithHeadline(dataKey: '_androidInfo.bootloader', dataValue: _androidInfo?.bootloader),
        DataStripWithHeadline(dataKey: '_androidInfo.brand', dataValue: _androidInfo?.brand),
        DataStripWithHeadline(dataKey: '_androidInfo.device', dataValue: _androidInfo?.device),
        DataStripWithHeadline(dataKey: '_androidInfo.display', dataValue: _androidInfo?.display),
        DataStripWithHeadline(dataKey: '_androidInfo.fingerprint', dataValue: _androidInfo?.fingerprint),
        DataStripWithHeadline(dataKey: '_androidInfo.hardware', dataValue: _androidInfo?.hardware),
        DataStripWithHeadline(dataKey: '_androidInfo.host', dataValue: _androidInfo?.host),
        DataStripWithHeadline(dataKey: '_androidInfo.id', dataValue: _androidInfo?.id),
        DataStripWithHeadline(dataKey: '_androidInfo.manufacturer', dataValue: _androidInfo?.manufacturer),
        DataStripWithHeadline(dataKey: '_androidInfo.model', dataValue: _androidInfo?.model),
        DataStripWithHeadline(dataKey: '_androidInfo.product', dataValue: _androidInfo?.product),
        DataStripWithHeadline(dataKey: '_androidInfo.supported32BitAbis', dataValue: _androidInfo?.supported32BitAbis),
        DataStripWithHeadline(dataKey: '_androidInfo.supported64BitAbis', dataValue: _androidInfo?.supported64BitAbis),
        DataStripWithHeadline(dataKey: '_androidInfo.supportedAbis', dataValue: _androidInfo?.supportedAbis),
        DataStripWithHeadline(dataKey: '_androidInfo.tags', dataValue: _androidInfo?.tags),
        DataStripWithHeadline(dataKey: '_androidInfo.type', dataValue: _androidInfo?.type),
        DataStripWithHeadline(dataKey: '_androidInfo.isPhysicalDevice', dataValue: _androidInfo?.isPhysicalDevice),
        DataStripWithHeadline(dataKey: '_androidInfo.systemFeatures', dataValue: _androidInfo?.systemFeatures),
        DataStripWithHeadline(dataKey: '_androidInfo.displayMetrics', dataValue: _androidInfo?.displayMetrics),

        DataStripWithHeadline(dataKey: '_androidInfo.version.baseOS', dataValue: _androidInfo?.version?.baseOS),
        DataStripWithHeadline(dataKey: '_androidInfo.version.codename', dataValue: _androidInfo?.version?.codename),
        DataStripWithHeadline(dataKey: '_androidInfo.version.incremental', dataValue: _androidInfo?.version?.incremental),
        DataStripWithHeadline(dataKey: '_androidInfo.version.previewSdkInt', dataValue: _androidInfo?.version?.previewSdkInt),
        DataStripWithHeadline(dataKey: '_androidInfo.version.release', dataValue: _androidInfo?.version?.release),
        DataStripWithHeadline(dataKey: '_androidInfo.version.sdkInt', dataValue: _androidInfo?.version?.sdkInt),
        DataStripWithHeadline(dataKey: '_androidInfo.version.securityPatch', dataValue: _androidInfo?.version?.securityPatch),

        const SeparatorLine(),

        /// IOS INFO
        SuperVerse(verse: Verse.plain('IOS DEVICE INFO'), size: 4, labelColor: Colorz.white50,),
        DataStripWithHeadline(dataKey: '_iosInfo.name', dataValue: _iosInfo?.name,),
        DataStripWithHeadline(dataKey: '_iosInfo.systemName', dataValue: _iosInfo?.systemName,),
        DataStripWithHeadline(dataKey: '_iosInfo.systemVersion', dataValue: _iosInfo?.systemVersion,),
        DataStripWithHeadline(dataKey: '_iosInfo.model', dataValue: _iosInfo?.model,),
        DataStripWithHeadline(dataKey: '_iosInfo.localizedModel', dataValue: _iosInfo?.localizedModel,),
        DataStripWithHeadline(dataKey: '_iosInfo.identifierForVendor', dataValue: _iosInfo?.identifierForVendor,),
        DataStripWithHeadline(dataKey: '_iosInfo.isPhysicalDevice', dataValue: _iosInfo?.isPhysicalDevice,),
        DataStripWithHeadline(dataKey: '_iosInfo.utsname', dataValue: _iosInfo?.utsname,),

        const SeparatorLine(),

        /// APP INFO
        SuperVerse(verse: Verse.plain('APP INFO'), size: 4, labelColor: Colorz.white50,),
        /// APP NAME
        DataStripWithHeadline(dataKey: 'AppName', dataValue: _packageInfo?.appName ),
        /// BUILD NUMBER
        DataStripWithHeadline(dataKey: 'App buildNumber', dataValue: _packageInfo?.buildNumber,),
        /// BUILD SIGNATURE
        DataStripWithHeadline(dataKey: 'App buildSignature', dataValue: _packageInfo?.buildSignature,),
        /// PACKAGE NAME
        DataStripWithHeadline(dataKey: 'packageName', dataValue: _packageInfo?.packageName,),
        /// VERSION
        DataStripWithHeadline(dataKey: 'App version', dataValue: _packageInfo?.version,),

        const SeparatorLine(),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
