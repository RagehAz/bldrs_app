/// https://medium.com/@juliomacr/10-firebase-realtime-database-rule-templates-d4894a118a98#:~:text=These%20rules%20are%20hosted%20on,and%20select%20the%20Rules%20tab.

/*

{
   "rules": {
    ".read": "auth.uid !== null",
    ".write": "auth.uid == 'z0Obwze3JLYjoEl6uVeXfo4Luup1'",
   	// --------------------
   	"bldrsChains": {
   	  ".read": true, // anyone
   	},
   	// --------------------
   	"citiesPhids": {
   	  ".read": true, // anyone
    	".write": "auth.uid !== null", // isAuthenticated
   	},
   	// --------------------
   	"feedbacks": {
   	  ".read": "auth.uid == 'z0Obwze3JLYjoEl6uVeXfo4Luup1'",
    	".write": "auth.uid !== null", // isAuthenticated
   	},
    // --------------------
    "phrases": {
   	  ".read": true, // anyone
    	".write": true, // anyone
   	},
    // --------------------
    "pickers": {
   	  ".read": true,
   	},
    // --------------------
   	"countingBzz": {
   	  ".read": true,
    	".write": true,
   	},
   	// --------------------
   	"countingFlyers": {
   	  ".read": true,
    	".write": true,
   	},

   	// --------------------
   	"notes": {
   	  ".read": true,
    	".write": true,
      "$receiverID": {
        ".indexOn": ["sentTime", "id", "spaceTime"],
        "$noteID": {
        },
      },

   	},
   	// --------------------

   	// --------------------
   	"recordingCalls": {
   	  ".read": true,
    	".write": true,
   	},
   	// --------------------
   	"recordingFollows": {
   	  ".read": true,
    	".write": true,
   	},
   	// --------------------
   	"recordingSaves": {
   	  ".read": true,
    	".write": true,
   	},
   	// --------------------
   	"recordingSearches": {
   	  ".read": true,
    	".write": true,
   	},
   	// --------------------
   	"recordingShares": {
   	  ".read": true,
    	".write": true,
   	},
   	// --------------------
   	"recordingViews": {
   	  ".read": true,
    	".write": true,
   	},
   	// --------------------

  }
}
// -----------------------------------------------------------------------------
// "$user":{
//   ".read": "$user == \"nico\""
// }
// --------------------
//
// auth.token.isOwner : ??
// auth.provider : ??
// auth.uid : is user id
// --------------------
// query.orderByChild
// query.orderByKey
// query.orderByValue
// query.equalTo
// query.limitToFirst < 50
// query.endAt
// query.limitToLast
// --------------------
// data returns RuleDataSnapshot
// data.parent().parent()
// --------------------
// newData : a snapshot of the newly inserted map
// "newData.child(\"fieldName\").exists() && ..."
// --------------------
// root.child('somewhere').child('some').val() == true
// -----------------------------------------------------------------------------
// {
//    "rules": {
//     ".read": false,
//     ".write": false,
//     "collName": {
//       	".read": false,
//     		".write": false,
//         "docName": {
//          	".read": false,
//     				".write": false,
//         },
//         "$everyThingElseOtherThanMentionedDocName": {
//           ".read": true,
//     				".write": "auth.uid !== null", // authenticated
//         },
//      },
//     "$someColl": {
//       ".read": false,
//       ".write": false,
//     	"$someDoc": {
//       	".read": "$someDoc === auth.uid", // docID == userID
//     		".write": "$someDoc === auth.uid",
//     	},
//     },
//   }
// }
// -----------------------------------------------------------------------------
// "agreesOnReviews": {
//      "$flyerID": {
//         ".indexOn": ["time", "number"],
//      }
//    }
// -----------------------------------------------------------------------------

 */
