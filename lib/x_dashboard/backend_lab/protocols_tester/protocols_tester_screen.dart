import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/x_dashboard/backend_lab/protocols_tester/progress_line_widget.dart';
import 'package:bldrs/x_dashboard/backend_lab/protocols_tester/progress_model.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class ProtocolsTester extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ProtocolsTester({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ProtocolsTesterState createState() => _ProtocolsTesterState();
  /// --------------------------------------------------------------------------
}

class _ProtocolsTesterState extends State<ProtocolsTester> {
  // -----------------------------------------------------------------------------
  static const String _userEmail = 'a_test_user@bldrs.net';
  static const String _userPassword = '123456';
  static const ZoneModel _userZone = ZoneModel(
    countryID: 'egy',
    cityID: 'egy+cairo',
    districtID: 'egy+cairo+el_zamalek',
  );
  // --------------------
  Map<String, dynamic> _progressMap = {

    /// 1. REGISTER USER BY EMAIL AND PASSWORD
    'registerUserByEmailAndPassword' : const ProgressModel(
      title: 'Register User by Email',
      state: ProgressState.nothing,
      args: {
        'Email': _userEmail,
        'Password': _userPassword,
      },
    ),

    /// 2. CHECK USER IS CREATED IN FIREBASE AUTH
    'checkUserIsCreatedInFirebaseAuth' : const ProgressModel(
      title: 'Check User is created',
      state: ProgressState.nothing,
    ),

    /// 3.


  };
  // --------------------
  void _setProtocolState({
    @required String key,
    @required ProgressState state,
    Map<String, dynamic> addArgs,
  }){

    final ProgressModel _progressModel = _progressMap[key];

    Mapper.blogMap(addArgs, invoker: 'Args');

    final Map<String, dynamic> _newArgs = Mapper.insertMapInMap(
      baseMap: _progressModel.args,
      insert: addArgs,
    );

    final ProgressModel _updatedProgressModel = _progressModel.copyWith(
      state: state,
      args: _newArgs,
    );

    final Map<String, dynamic> _updatedProgressMap = Mapper.insertPairInMap(
        map: _progressMap,
        key: key,
        value: _updatedProgressModel,
        overrideExisting: true,
      );

    setState(() {
      _progressMap = _updatedProgressMap;
    });

  }
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
  Future<void> _startTests() async {

    await _triggerLoading(setTo: true);

    await _startUserAuthTests();

    await _startCheckUserIsCreatedInFirebaseAuth();

    await _triggerLoading(setTo: false);

  }
  // --------------------
  Future<void> _startUserAuthTests() async {

    _setProtocolState(key: 'registerUserByEmailAndPassword', state: ProgressState.waiting);

    final AuthModel _authModel = await AuthFireOps.registerByEmailAndPassword(
        context: context,
        currentZone: _userZone,
        email: _userEmail,
        password: _userPassword
    );

    if (_authModel.authSucceeds == true){
      _setProtocolState(
        key: 'registerUserByEmailAndPassword',
        state: ProgressState.good,
        addArgs: _authModel.toMap(toJSON: true),
      );
    }
    else {
      _setProtocolState(
        key: 'registerUserByEmailAndPassword',
        state: ProgressState.error,
        addArgs: {
          'error': _authModel.authError,
        },
      );



    }

  }
  // --------------------
  Future<void> _startCheckUserIsCreatedInFirebaseAuth() async {

    _setProtocolState(key: 'checkUserIsCreatedInFirebaseAuth', state: ProgressState.waiting);

    final AuthModel _authModel = await AuthFireOps.signInByEmailAndPassword(
        email: _userEmail,
        password: _userPassword,
    );

    if (_authModel.authSucceeds == true){
      _setProtocolState(
        key: 'checkUserIsCreatedInFirebaseAuth',
        state: ProgressState.good,
        addArgs: _authModel.toMap(toJSON: true),
      );
    }
    else {
      _setProtocolState(
        key: 'checkUserIsCreatedInFirebaseAuth',
        state: ProgressState.error,
        addArgs: {
          'error': _authModel.authError,
        },
      );



    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final List<String> _keys = _progressMap.keys.toList();

    // --------------------
    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Protocols Tester',
      listWidgets: <Widget>[

        // WideButton(
        //   verse: Verse.plain('set progress state'),
        //   icon: Iconz.users,
        //   onTap: (){
        //
        //     final ProgressModel model = _progressMap['checkUserIsCreatedInFirebaseAuth'];
        //
        //     blog(model.title);
        //
        //     if (model.state == ProgressState.error){
        //     _setProtocolState(key: 'checkUserIsCreatedInFirebaseAuth', state: ProgressState.good,
        //       addArgs: {
        //       'fuck': 'you',
        //       },
        //     );
        //     }
        //     else {
        //       _setProtocolState(key: 'checkUserIsCreatedInFirebaseAuth', state: ProgressState
        //           .error,
        //       addArgs: {
        //         'ass': 'hole',
        //       },
        //       );
        //     }
        //
        //   },
        // ),

        WideButton(
          verse: Verse.plain('Start User Auth Tests'),
          icon: Iconz.users,
          onTap: _startTests,
        ),

        ...List.generate(_keys.length, (index) {

          return ProgressLine(
            progressModel: _progressMap[_keys[index]],
          );

        }),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

// 01000703303
// 10AM - 7PM
// 10GM 21700 5GM 10800
