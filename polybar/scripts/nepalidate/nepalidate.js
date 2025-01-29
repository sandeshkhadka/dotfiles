#!/usr/bin/env node

const NepaliDate = require('nepali-date-converter');
//import NepaliDate from 'nepali-date-converter';
let nepali_today= new NepaliDate();
let english_today = new Date();

let nepali_month = nepali_today.getMonth();
let english_month = english_today.getMonth();

let nepali_date = nepali_today.getDate();
let english_date = english_today.getDate();

let nepali_months_list = [
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

let english_months_list = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
]

console.log(`[${nepali_months_list[nepali_month]} ${nepali_date} | ${english_months_list[english_month]} ${english_date}]`);
