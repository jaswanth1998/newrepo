const functions = require('firebase-functions');
var request = require('request');


// The Firebase Admin SDK to access Cloud Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

apiKey = "rzp_test_8IbZwSARRQ1LA4"
apiScret = "XOTsMIygDiER9mXXLBND6EXp"

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

// Listen for any change on document `marie` in collection `users`
exports.bookingTrigger = functions.firestore
    .document('Appotiments/{AppotimentsId}').onCreate((snap, context) => {
        const AppotimentData = snap.data();
        const paymentId = AppotimentData["txnId"]
        var url = 'https://'+apiKey+':'+apiScret+'@api.razorpay.com/v1/payments/'+paymentId+'/capture';
        request({
            method: 'POST',
            url:url,
            form: {
              amount: AppotimentData['doctorFee']+"00",
              currency: INR
            }
          }, function (error, response, body) {
            console.log('Status:', response.statusCode);
            console.log('Headers:', JSON.stringify(response.headers));
            console.log('Response:', body);
          });
      // ... Your code here
    });


    // exports.bookingTrigger = functions.firestore
    // .document('Appotiments/{AppotimentsId}').onUpdate((change, context) => {
    //   const newValue = change.after.data();
    //     const AppotimentData = snap.after.data();
    //     const paymentId = AppotimentData["txnId"]
    //     if(newValue["refund"] == true && newValue["refunded"] == false ){
    //       var url = 'https://'+apiKey+':'+apiScret+'@api.razorpay.com/v1/payments/'+paymentId+'/refund';
    //       request({
    //         method: 'POST',
    //         url:url,
        
    //       }, function (error, response, body) {
    //         console.log('Status:', response.statusCode);
    //         console.log('Headers:', JSON.stringify(response.headers));
    //         console.log('Response:', body);
    //       });

    //     }
       
    //   // ... Your code here
    // });




//     var request = require('request');
// var options = {
//   'method': 'POST',
//   'url': 'https://fcm.googleapis.com/fcm/send',
//   'headers': {
//     'Content-Type': 'application/json',
//     'Authorization': 'key=AAAA2GJ6160:APA91bEoiPh5hjuuu9tpEmPrqKZ4bNq3R1RnjMr_OGnKIpect7Lug0IVwkVqU0Dm-GnOY63N0OC7pA7KiR-vRin-mAdJZt0xbMnIpeL35a9HxPmpH4G9HHHdxnBNtYCDFgHUPmGxZeFa'
//   },
//   body: JSON.stringify({"notification":{"body":"Your token is about to come","title":"Token Update"},"priority":"high","data":{"click_action":"FLUTTER_NOTIFICATION_CLICK","id":"1","status":"done"},"to":"dtl1nzFBQ0eKRDGlK7Yu78:APA91bE8a3RmN8F_qfdP-WK76pVg4E1nEQTfMAtatAKrstQMsE3ImzpB4o2lL_2eyFV8oqXHEQ5p1gmh6fVVZHkoXdGs7qlFW3IDp1zpSeO6Aa8eSuYFyP4D8UMhjYLs3BB8xL1WsZf5"})

// };
// request(options, function (error, response) {
//   if (error) throw new Error(error);
//   console.log(response.body);
// });
