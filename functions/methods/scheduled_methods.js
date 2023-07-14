// --------------------------------------------------------------------------

//  IMPORTS

// --------------------
const functions = require('firebase-functions');
const admin = require('firebase-admin');
// --------------------------------------------------------------------------

//  CALLABLES

// --------------------
// TESTED : WORKS PERFECT
const callTakeStatisticsSnapshot = functions.pubsub
  .schedule('every day 00:00')
  .timeZone('Etc/GMT')
  .onRun(async (context) => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString().split('T')[0].replace(/-/g, '_');
    functions.logger.log(`TakeStatisticsSnapshot : 1 : Starting to take statistics snapshot`);
    try {
      const snapshotStatistics = await admin.database().ref('statistics').once('value');
      const snapshotZonesPhids = await admin.database().ref('zonesPhids').once('value');

      if (snapshotStatistics.exists()) {
        const statisticsData = snapshotStatistics.val();
        functions.logger.log(`TakeStatisticsSnapshot : 2 : Got statistics map : [${statisticsData}]`);
        await admin.database().ref(`app/history/${formattedDate}/statistics`).set(statisticsData);
        functions.logger.log(`TakeStatisticsSnapshot : 3 : Statistics copied successfully`);
      } else {
        functions.logger.log(`TakeStatisticsSnapshot : 2 : No statistics data available`);
      }

      if (snapshotZonesPhids.exists()) {
        const zonesPhidsData = snapshotZonesPhids.val();
        functions.logger.log(`TakeStatisticsSnapshot : 4 : Got zonesPhids map: [${zonesPhidsData}]`);
        await admin.database().ref(`app/history/${formattedDate}/zonesPhids`).set(zonesPhidsData);
        functions.logger.log(`TakeStatisticsSnapshot : 5 : zonesPhids copied successfully`);
      } else {
        functions.logger.log(`TakeStatisticsSnapshot : 4 : No zonesPhids data available`);
      }
    } catch (error) {
      functions.logger.log(`TakeStatisticsSnapshot : X : ERROR : [${error}]`);
    }
  });
// --------------------------------------------------------------------------

//  MODULE EXPORTS

// -------------------------------------
module.exports = {
  'callTakeStatisticsSnapshot': callTakeStatisticsSnapshot,
};
// -------------------------------------
