/**
 * Need data for Order and OrderPart
 * Order contains  OrderID and CustomerID, StoreId, OrderDate (last 4 months),
 * Link 1-5 orderparts to each order
 * OrderPart contains OrderPartID, OrderID and PartID, Quantity (weighted 1-5), 
 */

const possibleStores = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10
];


// reserve 7,8,9,10
const possibleCustomers = [
    1, 2, 3, 4, 5, 6,
];

const possibleParts = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    111,
    112,
    113,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    200,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
];

const stockInserts = [];
const orderInserts = [];
const orderPartInserts = [];

const startingOrderID = 100;
let orderPartID = 100;
let stockID = 100;

function insertStatements() {

    for (const part of possibleParts) {
        for (const store of possibleStores) {
            const partStock = `INSERT dbo.Stock (StockId, PartId, StoreId, Quantity) VALUES (${stockID}, ${part}, ${store}, 100000);`
            stockID += 1;
            stockInserts.push(partStock);
        }
    }

    for (let i = 0; i < 100; i++) {
        const CustomerID = random(possibleCustomers);
        const StoreID = random(possibleStores);
        const orderID = startingOrderID + i;
        const orderInsert = `INSERT dbo.Orders (OrderID, CustomerID, StoreID, OrderDate)
      VALUES (${orderID},${CustomerID}, ${StoreID}, ${getRandomDate()});`
        orderInserts.push(orderInsert)


        for (let j = 0; j < weightedRandom({ 1: 8, 2: 7, 3: 6, 4: 5, 5: 4, 6: 3, 7: 2 }); j++) {
            let Quantity = weightedRandom({ 1: 8, 2: 7, 3: 6, 4: 3, 5: 2, 6: 1 });
            let PartID = random(possibleParts);
            const orderPartInsert = `INSERT dbo.OrderPart (OrderPartID, OrderID, PartID, Quantity)
        VALUES(${orderPartID}, ${orderID}, ${PartID}, ${Quantity});`
            orderPartID += 1;
            orderPartInserts.push(orderPartInsert)
        }
    }

    console.log('=============> STOCK INSERTS <=============')
    for (const si of stockInserts) console.log(si);
    console.log('=============> ORDER INSERTS <=============')
    for (const oi of orderInserts) console.log(oi);
    console.log('=============> ORDERPART INSERTS <=============')
    for (const op of orderPartInserts) console.log(op);
}

insertStatements();

function random(l) {
    const rand = Math.floor(Math.random() * l.length - 1) + 1;
    return l[rand];
}

function weightedRandom(obj) {
    let weightTotal = 0;
    const keys = Object.keys(obj);
    for (const key of keys) {
        weightTotal += obj[key];
    }
    const rand = Math.floor(Math.random() * weightTotal) + 1;
    let val = rand;
    for (const key of keys) {
        val -= obj[key];
        if (val <= 0) {
            return key;
        }
    }
    return keys[keys.length - 1];
}


function testWeightedRandom() {
    d = { 1: 0, 2: 0, 3: 0 }
    for (let i = 0; i < 400000; i++) {
        d[weightedRandom({ 1: 1, 2: 2, 3: 3 })] += 1;
    }
    console.log(d);
}


function getRandomDate(start = new Date('2020-03-01'), end = new Date()) {
    const date = new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
    return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
}