import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/chain_editor_controllers.dart';
import 'package:flutter/material.dart';

class ChainViewScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainViewScreen({
    @required this.chain,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  /// --------------------------------------------------------------------------
  @override
  State<ChainViewScreen> createState() => _ChainViewScreenState();
  /// --------------------------------------------------------------------------
}

class _ChainViewScreenState extends State<ChainViewScreen> {
// -----------------------------------------------------------------------------
  ValueNotifier<Chain> _chain;
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
    _chain = ValueNotifier(widget.chain);
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
    _chain.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: widget.chain.id,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        ValueListenableBuilder(
          valueListenable: _chain,
          builder: (_, Chain chain, Widget child){

            final bool _areIdentical = Chain.checkChainsPathsAreIdentical(
                chain1: chain,
                chain2: widget.chain,
            );

            return AppBarButton(
              verse: 'Sync',
              isDeactivated: _areIdentical,
              buttonColor: Colorz.yellow255,
              verseColor: Colorz.black255,
              onTap: () => onSyncChain(
                context: context,
                originalChain: widget.chain,
                editedChain: _chain.value,
              ),
            );

            },
        ),

      ],
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          child: ValueListenableBuilder(
            valueListenable: _chain,
            builder: (_, Chain chain, Widget child){

              // chain.blogChain();

              return ChainSplitter(
                initiallyExpanded: false,
                chainOrChainsOrSonOrSons: chain,
                onSelectPhid: (String path, String phid) => onPhidTap(
                  context: context,
                  path: path,
                  phid: phid,
                  tempChain: _chain,
                ),
                onAddToPath: (String path) => onAddNewPath(
                  context: context,
                  path: path,
                  tempChain: _chain,
                ),

              );

            },

          ),
        ),
      ),
    );

  }
}
