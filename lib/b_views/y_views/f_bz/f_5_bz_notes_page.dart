import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class BzNotesPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzNotesPage({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<BzNotesPage> createState() => _BzNotesPageState();
/// --------------------------------------------------------------------------
}

class _BzNotesPageState extends State<BzNotesPage> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {


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
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    // final List<AuthorModel> _authors = _bzModel.authors;
    // final bool _authorIsMaster = AuthorModel.checkUserIsMasterAuthor(
    //   userID: superUserID(),
    //   bzModel: _bzModel,
    // );

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        /// BZ NOTES HERE
        Container(),

      ],
    );

  }
}
