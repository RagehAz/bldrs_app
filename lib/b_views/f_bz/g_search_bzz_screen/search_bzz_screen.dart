import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/searching.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/z_components/buttons/bz_buttons/bzz_tile_buttons_list.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/loading/loading.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_search.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

Future<void> onSearchBzz({
  required String? text,
  required ValueNotifier<List<BzModel>?> foundBzz,
  required ValueNotifier<List<BzModel>> historyBzz,
  required ValueNotifier<bool> isSearching,
  required ValueNotifier<bool> loading,
  required bool mounted,
  QueryDocumentSnapshot<Object>? startAfter,
}) async {

  blog('starting onSearchUsers : text : $text');

  Searching.triggerIsSearchingNotifier(
      text: text,
      isSearching: isSearching,
      mounted: mounted,
      onSwitchOff: (){

        setNotifier(
            notifier: foundBzz,
            mounted: mounted,
            value: null,
        );

      }
  );

  if (isSearching.value  == true){

    setNotifier(notifier: loading, mounted: mounted, value: true);

    final String? _fixedText = TextMod.fixSearchText(text);

    final List<BzModel> _bzz = await BzSearch.paginateBzzBySearchingBzName(
      bzName: _fixedText,
      limit: 10,
      startAfter: startAfter,
    );

    await BzLDBOps.insertBzz(
      bzz: foundBzz.value,
    );

    setNotifier(notifier: foundBzz, mounted: mounted, value: _bzz);
    setNotifier(notifier: loading, mounted: mounted, value: false);

    /// TASK SHOULD INSERT BZ TO BZZ
    // historyBzz.value  = BzModel.addOrRemoveBzToBzz(
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
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool multipleSelection;
  final List<BzModel>? selectedBzz;
  final ValueChanged<BzModel>? onBzTap;
  /// --------------------------------------------------------------------------
  @override
  _SearchBzzScreenState createState() => _SearchBzzScreenState();
  /// --------------------------------------------------------------------------
}

class _SearchBzzScreenState extends State<SearchBzzScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<BzModel>?> _foundBzz = ValueNotifier(null);
  final ValueNotifier<List<BzModel>> _historyBzz = ValueNotifier(<BzModel>[]);
  final ValueNotifier<List<BzModel>> _selectedBzz = ValueNotifier(<BzModel>[]);
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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

    setNotifier(
        notifier: _selectedBzz,
        mounted: mounted,
        value: [...?widget.selectedBzz],
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        final List<BzModel> _history = await BzLDBOps.readAll();

        setNotifier(
            notifier: _historyBzz,
            mounted: mounted,
            value: _history,
        );

        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
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
  Future<void> _onSearch(String? text) async {

    await onSearchBzz(
      text: text,
      loading: _loading,
      foundBzz: _foundBzz,
      isSearching: _isSearching,
      historyBzz: _historyBzz,
      mounted: mounted,
    );

  }
  // --------------------
  Future<void> onBzTap(BzModel bzModel) async {

    /// WHEN SELECTION FUNCTION IS HANDLED INTERNALLY
    if (widget.onBzTap == null){

      /// CAN SELECT MULTIPLE USERS
      if (widget.multipleSelection == true){
        final List<BzModel> _newList = BzModel.addOrRemoveBzToBzz(
          bzzModels: _selectedBzz.value,
          bzModel: bzModel,
        );
        setNotifier(notifier: _selectedBzz, mounted: mounted, value: _newList);
      }

      /// CAN SELECT ONLY ONE USER
      else {

        final bool _isSelected = BzModel.checkBzzContainThisBz(
          bzz: _selectedBzz.value,
          bzModel: bzModel,
        );

        if (_isSelected == true){
          setNotifier(notifier: _selectedBzz, mounted: mounted, value: <BzModel>[]);
        }
        else {
          setNotifier(notifier: _selectedBzz, mounted: mounted, value: <BzModel>[bzModel]);
        }
      }

    }

    /// WHEN FUNCTION IS EXTERNALLY PASSED
    else {
      widget.onBzTap?.call(bzModel);
    }

  }
  // --------------------
  Future<void> _onBack() async {

    await Nav.goBack(
      context: context,
      invoker: 'SearchBzScreen._onBack',
      passedData: _selectedBzz.value,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canSwipeBack: true,
      skyType: SkyType.grey,
      title: const Verse(id: 'phid_search_bzz', translate: true),
      searchHintVerse: const Verse(id: 'phid_search_bzz_hint', translate: true),
      pyramidsAreOn: true,
      appBarType: AppBarType.search,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      loading: _loading,
      onBack: _onBack,
      child: ValueListenableBuilder(
            valueListenable: _isSearching,
            builder: (_, bool _isSearching, Widget? childA){

              return ValueListenableBuilder(
                valueListenable: _loading,
                builder: (_, bool _isLoading, Widget? childB){

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

    );

  }
  // -----------------------------------------------------------------------------
}
