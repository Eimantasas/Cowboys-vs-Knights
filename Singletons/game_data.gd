extends Node

var starting_money = 650
var current_money = 650
var tower_count = 0
var max_tower_count = 20
var gamewon = false

var tower_data = {
"OutlawT1": {
	"damage": 5,
	"rate": 1, #rate of fire
	"range": 400,
	"category": "bullet",
	"price": 150,
	"tier": 1},
"OutlawT2": {
	"damage": 15,
	"rate": 0.85, 
	"range": 500,
	"category": "bullet",
	"price": 800,
	"tier": 2},
"OutlawT3": {
	"damage": 25,
	"rate": 0.5, 
	"range": 500,
	"category": "bullet",
	"price": 1700,
	"tier": 3},
"MarksmanT1": {
	"damage": 10,
	"rate": 2,
	"range": 520,
	"category": "bullet",
	"price": 275,
	"tier": 1},
"MarksmanT2": {
	"damage": 25,
	"rate": 1.5,
	"range": 650,
	"category": "bullet",
	"price": 1050,
	"tier": 2},
"MarksmanT3": {
	"damage": 60,
	"rate": 1,
	"range": 800,
	"category": "bullet",
	"price": 3250,
	"tier": 3},
"GunnerT1": {
	"damage": 3,
	"rate": 0.2,
	"range": 500,
	"category": "bullet",
	"price": 700,
	"tier": 1},
"GunnerT2": {
	"damage": 4,
	"rate": 0.15,
	"range": 550,
	"category": "bullet",
	"price": 750,
	"tier": 2},
"GunnerT3": {
	"damage": 9,
	"rate": 0.1,
	"range": 600,
	"category": "bullet",
	"price": 4650,
	"tier": 3},
"DemomanT1": {
	"damage": 15,
	"rate": 4,
	"range": 400,
	"category": "projectile",
	"price": 350,
	"tier": 1},
"DemomanT2": {
	"damage": 55,
	"rate": 6,
	"range": 650,
	"category": "projectile",
	"price": 1050,
	"tier": 2},
"DemomanT3": {
	"damage": 110,
	"rate": 4,
	"range": 700,
	"category": "projectile",
	"price": 5250,
	"tier": 3}}
	
