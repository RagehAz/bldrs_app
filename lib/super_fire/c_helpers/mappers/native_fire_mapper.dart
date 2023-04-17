part of super_fire;

class NativeFireMapper {
  // -----------------------------------------------------------------------------

  const NativeFireMapper();

  // -----------------------------------------------------------------------------
  /// TASK : TEST ME
  static List<Map<String, dynamic>> getMapsFromNativePage({
    @required fd.Page<fd.Document> page,
    bool addDocsIDs = false,
  }) {
    final List<Map<String, dynamic>> _output = [];

    if (page != null && page.isNotEmpty == true) {
      for (final fd.Document _doc in page) {
        final Map<String, dynamic> _map = getMapFromNativeDoc(
          doc: _doc,
          addDocID: addDocsIDs,
        );

        _output.add(_map);
      }
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> getMapFromNativeDoc({
    @required fd.Document doc,
    bool addDocID = false,
  }) {
    Map<String, dynamic> _output;

    if (doc != null) {
      _output = doc.map;

      if (addDocID == true) {
        _output = Mapper.insertPairInMap(
          map: _output,
          key: 'id',
          value: doc.id,
        );
      }
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Map<String, dynamic>> mapDocs(List<fd.Document> docs) {
    final List<Map<String, dynamic>> _maps = NativeFireMapper.getMapsFromNativePage(
      page: docs,
      addDocsIDs: true,
    );
    return _maps;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> mapDoc(fd.Document doc) {
    final Map<String, dynamic> _map = NativeFireMapper.getMapFromNativeDoc(
      doc: doc,
      addDocID: true,
    );
    return _map;
  }
// -----------------------------------------------------------------------------
}
