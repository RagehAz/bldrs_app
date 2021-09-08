// const EventEmmiter = require('events');
// const eventEmmiter = new EventEmmiter();
//
// eventEmmiter.on("listenerEvent", (num1, num2) => {
//     console.log(`event has occured -------------------- : ${num1 + num2}`);
// });
//
// eventEmmiter.emit("listenerEvent", 5, 7);
//
// class Person extends EventEmmiter{
//     constructor(name){
//         super();
//         this._name = name;
//     }
//
//     get name(){
//         return this._name;
//     }
//
// }
//
//
//
// let pedro = new Person('pedroni');
// pedro.on('name', ()=>{
//     console.log('my name is ' + pedro.name);
// });
//
// pedro.emit('name');
// // const fire = admin.firestore();
// // const flyerDoc = "flyers/{flyerID}";
// // const userDoc = "users/{userID}";
// // const docStatistics = fire.collection("admin").doc("statistics");
// console.log('A - starting node dox');
// const sum = (num1,num2) => num1 + num2;
// const rageh = "rageh";
// const result = sum(1,2);
// console.log(result);
//
// class MathObject{
//     constructor(){
//         console.log("object created");
//     }
// }
//
// // module.exports.sum = {
// //     sum: sum,
// //     rageh: rageh,
// //     MathObject: new MathObject(),
// // };
//
// const mapa = {
//     one: sum(1,1),
//     two: sum(2,2),
//     three: sum(3,3),
// };
//
// module.exports.sum = sum;
// module.exports.rageh = rageh;
// module.exports.MathObject = MathObject;
// module.exports.map = mapa;