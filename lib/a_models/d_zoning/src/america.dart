part of world_zoning;

/// TESTED : WORKS PERFECT
List<Phrase> addUSAIDToPhrasesIfContainsStates({
  required List<Phrase> phrases,
}){
  final List<Phrase> _output = [...phrases];

  if (Lister.checkCanLoop(phrases) == true){

    final List<String> _phrasesIDs = Phrase.getPhrasesIDs(phrases);

    final bool _hasAStateID = America.checkCountriesIDsIncludeAStateID(
      countriesIDs: _phrasesIDs,
    );

    if (_hasAStateID == true){

      final String _langCode = Localizer.getCurrentLangCode();

      final Phrase _usaPhrase = Phrase(
        id: 'usa',
        value: CountryModel.translateCountry(
          countryID: 'usa',
          langCode: _langCode,
        ),
        langCode: _langCode, // trigram: [],
      );

      _output.add(_usaPhrase);

    }

  }

  return _output;
}
