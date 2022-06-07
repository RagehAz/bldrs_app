import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/e_db/fire/search/bz_search.dart' as BzFireSearch;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/x_dashboard/a_modules/f_bzz_manager/bz_long_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> onSearchBzz({
  @required BuildContext context,
  @required String text,
  @required ValueNotifier<List<BzModel>> foundBzz,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<bool> loading,
  QueryDocumentSnapshot<Object> startAfter,
}) async {

  blog('starting onSearchUsers : text : $text');

  triggerIsSearchingNotifier(
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

    foundBzz.value = _bzz;
    loading.value = false;

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
  ValueNotifier<List<BzModel>> _selectedBzz;
  final ValueNotifier<bool> _isSearching = ValueNotifier(false);
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  @override
  void initState() {
    super.initState();
    _selectedBzz = ValueNotifier<List<BzModel>>(widget.selectedBzz);
  }
// -----------------------------------------------------------------------------
  Future<void> _onSearch(String text) async {

    await onSearchBzz(
      context: context,
      text: text,
      loading: _loading,
      foundBzz: _foundBzz,
      isSearching: _isSearching,
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
                      return ValueListenableBuilder(
                          valueListenable: _foundBzz,
                          builder: (_, List<BzModel> foundBzz, Widget child){

                            /// FOUND USERS
                            if (Mapper.checkCanLoopList(foundBzz) == true){

                              return ValueListenableBuilder(
                                valueListenable: _selectedBzz,
                                builder: (_, List<BzModel> selectedBzz, Widget child){

                                  return SizedBox(
                                    width: Scale.superScreenWidth(context),
                                    height: Scale.superScreenHeight(context),
                                    child: ListView.builder(
                                      itemCount: foundBzz.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index){

                                        final BzModel _bzModel = foundBzz[index];
                                        final bool _isSelected = BzModel.checkBzzContainThisBz(
                                          bzz: selectedBzz,
                                          bzModel: _bzModel,
                                        );

                                        return BzLongButton(
                                          bzModel: _bzModel,
                                          isSelected: _isSelected,
                                          onTap: () => onBzTap(_bzModel),
                                        );

                                      },
                                    ),
                                  );

                                },
                              );

                            }

                            /// NO USERS FOUND
                            else {
                              return const SuperVerse(
                                verse: 'No users found with this name',
                              );
                            }

                          }
                      );
                    }

                  }

                  /// NOT SEARCHING
                  else {
                    return const SizedBox();
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
