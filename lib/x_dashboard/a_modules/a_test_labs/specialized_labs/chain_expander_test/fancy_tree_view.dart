import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

class FancyTreeTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FancyTreeTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FancyTreeTestState createState() => _FancyTreeTestState();
/// --------------------------------------------------------------------------
}

class _FancyTreeTestState extends State<FancyTreeTest> {
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

  TreeNode _initialNode;

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _initialNode = TreeNode(

      id: 'Root',
      label: 'Label',
      data: {
        'Root' : ['thing', 'is'],
        'thing' : ['fuck'],
        'is' : ['you'],
      },
    );

    _scrollController = ScrollController();
    _treeViewController = TreeViewController(
      rootNode: _initialNode,
      // useBinarySearch: false,
      onAboutToExpand: (TreeNode treeNode){

        blog('onAboutToExpand : ${treeNode.id}');
        blog('onAboutToExpand : ${treeNode.data}');

      }
    );
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
    _treeViewController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  TreeViewController _treeViewController;
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {

    // final TreeNodeScope treeNodeScope = TreeNodeScope.of(context);

    blog('a77a ?');

    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        WideButton(
          verse: 'Fuck this',
          onTap: () async {

            blog('fuck this');

            _initialNode.addChild(TreeNode(
              id: 'a77a',
              label: 'fook',
              data: {'what' : 'is this'},
            ));

          },
        ),

        Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenWidth(context),
          color: Colorz.white20,
          child: TreeView(
            shrinkWrap: true,
            controller: _treeViewController,
            scrollController: _scrollController,
            // nodeHeight: 40,
            theme: const TreeViewTheme(
              indent: 10,
              lineColor: Colorz.yellow255,
              // lineStyle: LineStyle.connected,
              lineThickness: 1,
              roundLineCorners: true,
            ),
            // padding: ,
            nodeBuilder: (_, TreeNode node){

              blog('node is : ${node.id}');

              return Center(
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colorz.bloodTest,
                  child: SuperVerse(
                    verse: '${node.id} : ${node.label}',
                  ),
                ),
              );

            },
          ),
        ),

      ],
    );

  }

}
