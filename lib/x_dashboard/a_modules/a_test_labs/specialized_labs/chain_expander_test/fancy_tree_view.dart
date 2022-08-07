import 'package:bldrs/b_views/z_components/chains_drawer/parts/chain_expander/a_chain_expander_starter.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ChainTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ChainTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ChainTestState createState() => _ChainTestState();
/// --------------------------------------------------------------------------
}

class _ChainTestState extends State<ChainTest> {
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
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }


// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
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
    _scrollController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {

    // final TreeNodeScope treeNodeScope = TreeNodeScope.of(context);

    blog('a77a ?');

    return Scaffold(
      backgroundColor: Colorz.black255,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ChainExpanderStarter(
            chain: ChainsProvider.proGetKeywordsChain(context: context, getRefinedCityChain: false, listen: false),
            boxWidth: Scale.superScreenWidth(context),
            icon: Iconz.keyword,
            firstHeadline: 'FUck',
            initiallyExpanded: false,
            secondHeadline: 'you',
            selectedKeywordsIDs: const <String>[],
          ),
        ),
      ),
    );


    // return DashBoardLayout(
    //   loading: _loading,
    //   listWidgets: <Widget>[
    //
    //     // WideButton(
    //     //   verse: 'Fuck this',
    //     //   onTap: () async {
    //     //
    //     //     blog('fuck this');
    //     //
    //     //
    //     //
    //     //   },
    //     // ),
    //
    //     Container(
    //       width: Scale.superScreenWidth(context),
    //       height: Scale.superScreenHeight(context),
    //       color: Colorz.white20,
    //       child: ,
    //
    //       // child: TreeView(
    //       //   startExpanded: false,
    //       //   children: [
    //       //
    //       //     TreeViewChild(
    //       //         parent: ChainSonButton(
    //       //           phid: 'phid_design',
    //       //           sonWidth: 200,
    //       //           parentLevel: 0,
    //       //           color: Colorz.bloodTest,
    //       //           // isDisabled: false,
    //       //           onTap: () => blog('fuck'),
    //       //         ),
    //       //         children: [
    //       //
    //       //           ChainSonButton(
    //       //             phid: 'phid_design',
    //       //             sonWidth: 200,
    //       //             parentLevel: 0,
    //       //             color: Colorz.bloodTest,
    //       //             // isDisabled: false,
    //       //             onTap: () => blog('fuck'),
    //       //           ),
    //       //
    //       //           ChainSonButton(
    //       //             phid: 'phid_design',
    //       //             sonWidth: 200,
    //       //             parentLevel: 0,
    //       //             color: Colorz.bloodTest,
    //       //             // isDisabled: false,
    //       //             onTap: () => blog('fuck'),
    //       //           )
    //       //
    //       //         ],
    //       //     ),
    //       //
    //       //   ],
    //       // ),
    //     ),
    //
    //   ],
    // );

  }

}
