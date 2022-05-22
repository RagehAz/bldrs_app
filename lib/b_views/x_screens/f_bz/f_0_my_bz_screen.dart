import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_0_my_bz_screen_view.dart';
import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/f_my_bz_screen_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBzScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    @required this.bzModel,
    Key key
  }) : super(key: key);

  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  _MyBzScreenState createState() => _MyBzScreenState();
/// --------------------------------------------------------------------------
}

class _MyBzScreenState extends State<MyBzScreen> with SingleTickerProviderStateMixin {
// -----------------------------------------------------------------------------
  TabController _tabController;
  UiProvider _uiProvider;
  BzzProvider _bzzProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    _tabController = TabController(
      vsync: this,
      length: BzModel.bzPagesTabsTitlesInEnglishOnly.length,
      initialIndex: getInitialMyBzScreenTabIndex(context),
    );

    _tabController.animation.addListener(
            () => onChangeMyBzScreenTabIndexWhileAnimation(
          context: context,
          tabController: _tabController,
        )
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _uiProvider.startController(
              () async {

                _uiProvider.triggerLoading(
                  setLoadingTo: true,
                  notify: true,
                  callerName: 'MyBzScreen didChangeDependencies',
                );

                await initializeMyBzScreen(
                  context: context,
                  bzModel: widget.bzModel,
                );

                _uiProvider.triggerLoading(
                  setLoadingTo: false,
                  callerName: 'MyBzScreen didChangeDependencies',
                  notify: true,
                );

              }
              );

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _canBuild(BuildContext context){


    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

    final List<FlyerModel> _bzFlyers = BzzProvider.proGetActiveBzFlyers(
        context: context,
        listen: true,
    );

    final bool _isLoading =  _uiProvider.isLoading;


    if (
    _bzModel != null
    &&
    _bzFlyers != null
    &&
    _isLoading == false
    ){
      return true;
    }

    else {
      return false;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _canBuildWidgets = _canBuild(context);

    return MainLayout(
      key: ValueKey('my_bz_screen_${widget.bzModel.id}'),
        appBarType: AppBarType.basic,
        skyType: SkyType.black,
        pyramidsAreOn: true,
        sectionButtonIsOn: false,
        zoneButtonIsOn: false,
        onBack: () => onCloseMyBzScreen(context: context),
        appBarRowWidgets: <Widget>[
          if (_canBuildWidgets == true)
            const BzAppBar(),
        ],
        layoutWidget:
        _canBuildWidgets == true ?
        MyBzScreenView(
          tabController: _tabController,
        )
            :
        const SizedBox()

    );

  }
}
