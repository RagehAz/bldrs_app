import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chains_manager_controllers.dart';
import 'package:flutter/material.dart';

class ChainEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainEditorScreen({
    @required this.chain,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  /// --------------------------------------------------------------------------
  @override
  State<ChainEditorScreen> createState() => _ChainEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainEditorScreenState extends State<ChainEditorScreen> {
// -----------------------------------------------------------------------------
  ValueNotifier<Chain> _initialChain;
  ValueNotifier<Chain> _tempChain;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initialChain = ValueNotifier( widget.chain);
    _tempChain = ValueNotifier( widget.chain);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _tempChain.dispose();
    _initialChain.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitleVerse: widget.chain.id,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        ValueListenableBuilder(
            valueListenable: _initialChain,
            builder: (_, Chain initialChain, Widget child){

          return ValueListenableBuilder(
            valueListenable: _tempChain,
            builder: (_, Chain tempChain, Widget child){

              final bool _areIdentical = Chain.checkChainsPathsAreIdentical(
                chain1: tempChain,
                chain2: initialChain,
              );

              return AppBarButton(
                verse:  'Sync',
                isDeactivated: _areIdentical,
                buttonColor: Colorz.yellow255,
                verseColor: Colorz.black255,
                onTap: () => onSyncChain(
                  context: context,
                  initialChain: _initialChain,
                  editedChain: _tempChain.value,
                ),
              );

            },
          );

        }),

      ],
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          child: ValueListenableBuilder(
            valueListenable: _tempChain,
            builder: (_, Chain tempChain, Widget child){

              // chain.blogChain();

              return ChainSplitter(
                initiallyExpanded: false,
                chainOrChainsOrSonOrSons: tempChain,
                onSelectPhid: (String path, String phid) => onPhidTap(
                  context: context,
                  path: path,
                  phid: phid,
                  tempChain: _tempChain,
                ),
                onAddToPath: (String path) => onAddNewPath(
                  context: context,
                  path: path,
                  tempChain: _tempChain,
                ),

              );

            },

          ),
        ),
      ),
    );

  }
}
