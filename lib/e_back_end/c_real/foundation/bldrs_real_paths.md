```
  | => REAL DATA TREE -------------------------|
  |
  | - []
  |     | - {bzID}
  |     |       | - {flyerID}
  |     |       |     | - {reviewID}
  |     |       |     |     | - {userID} : <bool>
  |     |       |     |     | - {userID} ...
  |     |       |     |
  |     |       |     | - {reviewID} ...
  |     |       |
  |     |       | - {flyerID} ...
  |     |
  |     | - {bzID}...
  |
  | --------------------------|
  |
  | - [app]
  |     | - [appState] : <AppStateModel>
  |
  | --------------------------|
  |
  | - [bldrsChains]
  |     | - {phid_k} : <String>
  |     | - {phid_k} ...
  |
  | --------------------------|
  |
  | - [recorders]
  |     | - [bzz]
  |     |       | - {bzID}
  |     |       |       | - [counter] : <BzCounterModel>
  |     |       |       | - [recordingCalls]
  |     |       |       |       | - {recordID} : <RecordModel>
  |     |       |       |       | - {recordID} ...
  |     |       |       |
  |     |       |       | - [recordingFollows]
  |     |       |               | - {recordID} : <RecordModel>
  |     |       |               | - {recordID} ...
  |     |       |     
  |     |       | - {bzID}...
  |     |
  |     | - [flyers]
  |             | - {bzID}
  |             |       | - {flyerID} :
  |             |       |       | - [counter] : <FlyerCounterModel>
  |             |       |       | - [recordingSaves]
  |             |       |       |       | - {recordID} : <RecordModel>
  |             |       |       |       | - {recordID} ...
  |             |       |       |   
  |             |       |       | - [recordingShares]
  |             |       |       |       | - {recordID} : <RecordModel>
  |             |       |       |       | - {recordID} ...
  |             |       |       |   
  |             |       |       | - [recordingViews]
  |             |       |               | - {recordID} : <RecordModel>
  |             |       |               | - {recordID} ...
  |             |       |
  |             |       | - {flyerID} ...       
  |             |       
  |             | - {bzID} ...
  |             
  | --------------------------|
  |
  | - [feedbacks]
  |     | - {feedbackID} : <FeedbackModel>
  |     | - {feedbackID} ...
  |
  | --------------------------|
  |
  | - [phrases]
  |     | - {langCode}
  |     |     | - {phid} : <String>
  |     |     | - {phid} ...
  |     |
  |     | - {langCode} ...
  |
  | --------------------------|
  |
  | - [pickers]
  |     | - {flyerType}
  |     |     | - {pickerID} : <PickerModel>
  |     |     | - {pickerID} ...
  |     |
  |     | - {flyerType} ...
  |
  | --------------------------|
  |
  | - [searches]
  |     | - {userID}
  |     |     | - {searchID} : <SearchModel>
  |     |     | - {searchID} ...
  |     |
  |     | - {userID} ...
  |
  |
  | --------------------------|
  |
  | - [statistics]
  |     | - [planet] : <CensusModel>
  |     |
  |     | - [countries]
  |     |     | - {countryID} : <CensusModel>
  |     |     | - {countryID} ...
  |     |
  |     | - [cities]
  |           | - {countryID}
  |           |     | - {cityID} : <CensusModel>
  |           |     | - {cityID} ...
  |           |
  |           | - {countryID} ...
  |
  | --------------------------|
  |
  | - [zones]
  |     | - [cities]
  |     |     | - {countryID}
  |     |     |     |- {cityID} : <CityModel>
  |     |     |     |- {cityID} ...
  |     |     |
  |     |     | - {countryID} ...
  |     |
  |     | - [stages_cities]
  |     |     | - {countryID} : <StagingModel>
  |     |     | - {countryID}...
  |     |
  |     | - [stages_countries] : <StagingModel>
  |
  | --------------------------|
  |
  | - [zonesPhids]
  |     | - {countryID}
  |     |     | - {cityID} : 
  |     |     |     | - {phid_k} : <int>
  |     |     |     | - {phid_k} ...
  |     |     |
  |     |     | - {cityID} ...
  |     |
  |     | - {countryID} ...
  |
  | -------------------------------------------|
```
