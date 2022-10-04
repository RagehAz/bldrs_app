import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/f_bzz_manager/bz_long_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BzzManagerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzzManagerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _BzzManagerScreenState createState() => _BzzManagerScreenState();
  /// --------------------------------------------------------------------------
}

class _BzzManagerScreenState extends State<BzzManagerScreen> {
  // -----------------------------------------------------------------------------
  final TextEditingController _searchController = TextEditingController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'BzzManagerScreen',);
    }
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
    super.didChangeDependencies();
    if (_isInit) {
      _triggerLoading().then((_) async {
        /// ---------------------------------------------------------0

        await _readMoreBzz();

        /// ---------------------------------------------------------0
      });
    }
    _isInit = false;
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _searchController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  QueryDocumentSnapshot<Object> _lastSnapshot;
  final List<BzModel> _bzzModels = <BzModel>[];
  Future<dynamic> _readMoreBzz() async {
    final List<dynamic> _bzzMaps = await Fire.readCollectionDocs(
      context: context,
      collName: FireColl.bzz,
      orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
      limit: 100,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    if (Mapper.checkCanLoopList(_bzzMaps) == true){
      setState(() {
        _lastSnapshot = _bzzMaps[_bzzMaps.length - 1]['docSnapshot'];
        _bzzModels.addAll(BzModel.decipherBzz(maps: _bzzMaps, fromJSON: false));
      });
    }

    _loading.value = false;
  }
  // --------------------
  List<BzModel> _searchedBzz = <BzModel>[];
  void _onSearchChanged(String value) {
    final String val = TextMod.removeSpacesFromAString(value);

    final bool _searchValueIsEmpty = val == '';
    final bool _searchResultIsEmpty = _searchedBzz.isEmpty;

    /// A - when field has NO value
    if (_searchValueIsEmpty) {
      /// B - when search result has values
      if (_searchResultIsEmpty == false) {
        setState(() {
          _searchedBzz = <BzModel>[];
        });
      }

      /// B - when search result has No values
      else {}
    }

    /// A - when field has value
    else {
      for (final BzModel tinyBz in _bzzModels) {

        final bool _matchFound = TextCheck.stringContainsSubString(
          string: tinyBz.name.toLowerCase(),
          subString: val.toLowerCase(),
        );

        final bool _alreadyInList = BzModel.checkBzzContainThisBz(
          bzz: _searchedBzz,
          bzModel: tinyBz,
        ) ==
            true;

        // blog('_alreadyInList : ${tinyBz.bzID} : $_alreadyInList');

        if (_alreadyInList == true) {
          if (_matchFound == true) {
          } else {
            setState(() {
              _searchedBzz.remove(tinyBz);
            });
          }
        } else {
          if (_matchFound == true) {
            setState(() {
              _searchedBzz.add(tinyBz);
            });
          } else {}
        }
      }
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    // --------------------
    final List<BzModel> _bzz = _searchedBzz.isEmpty ? _bzzModels : _searchedBzz;
    // --------------------
    return _bzzModels == null ?
    const LoadingFullScreenLayer()
        :
    MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.search,
      pageTitleVerse: Verse.plain('${_bzzModels.length} Bzz Manager'),
      loading: _loading,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      searchController: _searchController,
      onSearchSubmit: (String val) => _onSearchChanged(val),
      historyButtonIsOn: false,
      onSearchChanged: (String val) => _onSearchChanged(val),
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight, color: Colorz.blue80,
        alignment: Alignment.topCenter,
        child: ListView.builder(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          itemExtent: BzLongButton.extent,
          itemCount: _bzz.length,
          padding: const EdgeInsets.only(
              bottom: Ratioz.stratosphere,
              top: Stratosphere.bigAppBarStratosphere
          ),
          itemBuilder: (BuildContext ctx, int index) {

            final BzModel _bz = _bzz[index];

            return BzLongButton(
              bzModel: _bz,
            );
          },
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
