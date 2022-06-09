import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/pagination_and_streaming/fire_coll_paginator.dart';
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
  final ScrollController _controller = ScrollController();
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
    _controller.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    // final List<AuthorModel> _authors = _bzModel.authors;
    // final bool _authorIsMaster = AuthorModel.checkUserIsMasterAuthor(
    //   userID: superUserID(),
    //   bzModel: _bzModel,
    // );

    blog('fuck youuufffffffff');

    return FireCollPaginator(
        queryParameters: BzModel.allReceivedBzNotesQueryParameters(
          bzModel: _bzModel,
          context: context,
        ),
        scrollController: _controller,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

          final List<NoteModel> _notes = NoteModel.decipherNotesModels(
            maps: maps,
            fromJSON: false,
          );

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            itemCount: _notes.length,
            itemBuilder: (_, int index){

              final NoteModel _note = _notes[index];

              return NoteCard(
                noteModel: _note,
                isDraftNote: false,
                // onNoteOptionsTap: null,
                // onCardTap: null,
              );

            },
          );

        }
    );

  }
}
