import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_db/fire/search/bz_search.dart' as BzFireSearch;
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/components/bzz_tile_buttons_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> onSearchBzz({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<List<BzModel>> foundBzz,
  @required ValueNotifier<List<BzModel>> historyBzz,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<bool> loading,
  QueryDocumentSnapshot<Object> startAfter,
}) async {

  blog('starting onSearchUsers : text : $text');

  TextChecker.triggerIsSearchingNotifier(
      text: text,
      isSearching: isSearching,
      onSwitchOff: (){
        foundBzz.value = null;
      }
  );

  if (isSearching.value == true){

    loading.value = true;

    final String _fixedText = TextMod.fixSearchText(text);

    final List<BzModel> _bzz = await BzFireSearch.paginateBzzBySearchingBzName(
      context: context,
      bzName: _fixedText,
      limit: 10,
      startAfter: startAfter,
    );

    await BzLDBOps.insertBzz(
      bzz: foundBzz.value,
    );


    foundBzz.value = _bzz;
    loading.value = false;

    /// TASK SHOULD INSERT BZ TO BZZ
    // historyBzz.value = BzModel.addOrRemoveBzToBzz(
    //     bzzModels: bzzModels,
    //     bzModel: bzModel
    // );

  }

}

class SearchBzzScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SearchBzzScreen({
    this.multipleSelection = false,
    this.selectedBzz,
    this.onBzTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool multipleSelection;
  final List<BzModel> selectedBzz;
  final ValueChanged<BzModel> onBzTap;
  /// --------------------------------------------------------------------------
  @override
  _SearchBzzScreenState createState() => _SearchBzzScreenState();
/// --------------------------------------------------------------------------
}

class _SearchBzzScreenState extends State<SearchBzzScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<BzModel>> _foundBzz = ValueNotifier(null);
  final ValueNotifier<List<BzModel>> _historyBzz = ValueNotifier(<BzModel>[]);
  ValueNotifier<List<BzModel>> _selectedBzz;
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SearchBzzScreen',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _selectedBzz = ValueNotifier<List<BzModel>>(widget.selectedBzz);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        final List<BzModel> _history = await BzLDBOps.readAll();
        _historyBzz.value = _history;

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _historyBzz.dispose();
    _loading.dispose();
    _foundBzz.dispose();
    _isSearching.dispose();
    _selectedBzz.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSearch(String text) async {

    await onSearchBzz(
      context: context,
      text: text,
      loading: _loading,
      foundBzz: _foundBzz,
      isSearching: _isSearching,
      historyBzz: _historyBzz,
    );

  }
// -----------------------------------------------------------------------------
  Future<void> onBzTap(BzModel bzModel) async {

    /// WHEN SELECTION FUNCTION IS HANDLED INTERNALLY
    if (widget.onBzTap == null){

      /// CAN SELECT MULTIPLE USERS
      if (widget.multipleSelection == true){
        final List<BzModel> _newList = BzModel.addOrRemoveBzToBzz(
          bzzModels: _selectedBzz.value,
          bzModel: bzModel,
        );
        _selectedBzz.value = _newList;
      }

      /// CAN SELECT ONLY ONE USER
      else {

        final bool _isSelected = BzModel.checkBzzContainThisBz(
            bzz: _selectedBzz.value,
            bzModel: bzModel,
        );

        if (_isSelected == true){
          _selectedBzz.value = null;
        }
        else {
          _selectedBzz.value = <BzModel>[bzModel];
        }
      }

    }

    /// WHEN FUNCTION IS EXTERNALLY PASSED
    else {
      widget.onBzTap(bzModel);
    }

  }
// -----------------------------------------------------------------------------
  void _onBack(){

    Nav.goBack(context, passedData: _selectedBzz.value);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: 'Search Businesses',
      searchHint: 'Search Business accounts by name',
      pyramidsAreOn: true,
      appBarType: AppBarType.search,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      loading: _loading,
      onBack: _onBack,
      layoutWidget: ListView(
        children: <Widget>[

          const Stratosphere(bigAppBar: true),

          ValueListenableBuilder(
            valueListenable: _isSearching,
            builder: (_, bool _isSearching, Widget childA){

              return ValueListenableBuilder(
                valueListenable: _loading,
                builder: (_, bool _isLoading, Widget childB){

                  /// SEARCHING
                  if (_isSearching == true){

                    /// LOADING
                    if (_isLoading == true){
                      return const Center(
                        child: Loading(loading: true),
                      );
                    }

                    /// NOT LOADING
                    else {
                      return BzzTilesButtonsList(
                        bzzModel: _foundBzz,
                        selectedBzz: _selectedBzz,
                        onTap: onBzTap,
                      );
                    }

                  }

                  /// NOT SEARCHING
                  else {
                    return BzzTilesButtonsList(
                      bzzModel: _historyBzz,
                      selectedBzz: _selectedBzz,
                      onTap: onBzTap,
                    );
                  }

                },
              );


            },
          ),

        ],
      ),

    );

  }

}
