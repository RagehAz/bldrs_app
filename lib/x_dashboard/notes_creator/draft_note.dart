import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:flutter/material.dart';

class DraftNote {
  /// --------------------------------------------------------------------------
  const DraftNote({
    @required this.formKey,
    @required this.titleController,
    @required this.titleNode,
    @required this.bodyController,
    @required this.bodyNode,
    @required this.noteNotifier,
    @required this.receiversModels,
    @required this.scrollController,
  });
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final FocusNode titleNode;
  final TextEditingController bodyController;
  final FocusNode bodyNode;
  final ValueNotifier<NoteModel> noteNotifier;
  final ValueNotifier<List<dynamic>> receiversModels;
  final ScrollController scrollController;
  // -----------------------------------------------------------------------------

  /// INITIALIZE

  // --------------------
  static DraftNote initialize(){
    return DraftNote(
      formKey: GlobalKey<FormState>(),
      titleController: TextEditingController(),
      titleNode: FocusNode(),
      bodyController: TextEditingController(),
      bodyNode: FocusNode(),
      noteNotifier: ValueNotifier<NoteModel>(NoteModel.initialNoteForCreation),
      receiversModels: ValueNotifier<List<dynamic>>([]),
      scrollController: ScrollController(),
    );
  }
  // -----------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  void dispose(){
    titleController.dispose();
    titleNode.dispose();
    bodyController.dispose();
    bodyNode.dispose();
    noteNotifier.dispose();
    receiversModels.dispose();
    scrollController.dispose();
  }
  // -----------------------------------------------------------------------------
}
