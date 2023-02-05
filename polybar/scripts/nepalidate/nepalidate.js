#!/bin/node

const NepaliDate = require('nepali-date-converter');
//import NepaliDate from 'nepali-date-converter';
let today= new NepaliDate();

let month = today.getMonth();
let date = today.getDate();
let months = [
    "Baishak",
    "Jestha",
    "Ashar",
    "Shrawan",
    "Bhadra",
    "Ashoj",
    "Kartik",
    "Mangsir",
    "Poush",
    "Magh",
    "Falgun",
    "Chaitra",
];

console.log(`${months[month]} ${date}`);

