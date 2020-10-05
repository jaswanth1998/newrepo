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


    exports.bookingTrigger = functions.firestore
    .document('Appotiments/{AppotimentsId}').onUpdate((change, context) => {
      const newValue = change.after.data();
        const AppotimentData = snap.after.data();
        const paymentId = AppotimentData["txnId"]
        if(newValue["refund"] == true && newValue["refunded"] == false ){
          var url = 'https://'+apiKey+':'+apiScret+'@api.razorpay.com/v1/payments/'+paymentId+'/refund';
          request({
            method: 'POST',
            url:url,
        
          }, function (error, response, body) {
            console.log('Status:', response.statusCode);
            console.log('Headers:', JSON.stringify(response.headers));
            console.log('Response:', body);
          });

        }
       
      // ... Your code here
    });