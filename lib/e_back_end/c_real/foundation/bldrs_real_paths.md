```
  | => REAL DATA TREE -------------------------|
  |
  | - [agrees]
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
  |     | - [tests]
  |     |     | - WHATEVER
  |     |     | - ...
  |     |
  |     | - [history]
  |     |       | - {yyyy_mm_dd}
  |     |       |       | - [statistics] : <statistics-Node>
  |     |       |       | - [zonePhids] : <zonePhids-Node>
  |     |       |                   
  |     |       | - {yyyy_mm_dd} ...  
  |     |
  |     | - [noteCampaigns]
  |           | - {campaignID} : <NoteCampaign>
  |           | - {campaignID} ... 
  |
  | --------------------------|
  |
  | - [bldrsChains]
  |     | - {phid_k} : <String>
  |     | - {phid_k} ...
  |
  | --------------------------|
  |
  | - [records]
  |     |
  |     | here we need to record user activity log
  |     | sessionStartTime - views - saves - reviews - shares - follows - calls
  |     | - [users]
  |     |       | - {userID}
  |     |       |       | - [counter] : <UserCounterModel>
  |     |       |       | - [records]
  |     |       |               | - {d_yyyy_mm_dd} : 
  |     |       |               |       | - {recordID} : RecordID(
  |     |       |               |       |                 recordType: <RecordType>,
  |     |       |               |       |                 modelID: <String>,
  |     |       |               |       |                 time: <DateTime>,
  |     |       |               |       |               )
  |     |       |               |       | - {recordID} ...
  |     |       |               |
  |     |       |               | - {d_yyyy_mm_dd} ...
  |     |       |
  |     |       | - {userID} ...
  |     |
  |     | - [bzz]
  |     |     | - {bzID}
  |     |     |      | - [counter] : <BzCounterModel>
  |     |     |      | - [recordingCalls]
  |     |     |      |       | - {callID} : CallModel(
  |     |     |      |       |                   userID: <userID>,
  |     |     |      |       |                   authorID: <authorID>,
  |     |     |      |       |                   time: <DateTime>,
  |     |     |      |       |                   contact: <String>,
  |     |     |      |       |                 )
  |     |     |      |       | - {callID} ...
  |     |     |      |
  |     |     |      |
  |     |     |      | - [recordingFollows]  
  |     |     |               | - {userID} : {time}
  |     |     |               | - {userID} ...
  |     |     |
  |     |     | - {bzID} ...
  |     |
  |     |
  |     | - [flyers]
  |             | - {bzID}
  |             |       | - {flyerID} :
  |             |       |       | - [counter] : <FlyerCounterModel>
  |             |       |       | - [recordingSaves]
  |             |       |       |       | - {userID} : SaveModel(
  |             |       |       |       |                 index: <int>,
  |             |       |       |       |                 time: <DateTime>,
  |             |       |       |       |               )
  |             |       |       |       | - {userID} ...
  |             |       |       |   
  |             |       |       | - [recordingShares]
  |             |       |       |       | - {shareID} : ShareModel(
  |             |       |       |       |                 index: <int>,
  |             |       |       |       |                 userID: <String>,
  |             |       |       |       |                 time: <DateTime>,
  |             |       |       |       |               )
  |             |       |       |       | - {shareID} ...
  |             |       |       |   
  |             |       |       | - [recordingViews]
  |             |       |               | - {userID_index} : {time}
  |             |       |               | - {userID_index} ...
  |             |       |
  |             |       | - {flyerID} ...       
  |             |       
  |             | - {bzID} ...
  |      
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
  | --------------------------|
  |
  | - [gta]
  |     | - [selected]
  |     |     | - {id} : <String>
  |     |     | - {id} ...
  |     |
  |     | - [scrapped]
  |     |     | - {id} : <GtaModel>
  |     |     | - {id} ...
  |     |
  |     | - [version]
  |           | - [value] : <int>
  |     
  | -------------------------------------------|
```

------------------------------------------------------------------------
