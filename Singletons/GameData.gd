extends Node


var tower_data = {
	"Gun":{
		"unlocked" : true,
		"cost" : 25,		
		"damage" : 25,
		"rof" : 1,
		"range" : 400,
		"category" : "Bullet",
		"pack_cost" : 50
	},
	"Missile":{
		"unlocked" : false,
		"cost" : 25,
		"damage" : 25,
		"rof" : 1.5,
		"range" : 500,
		"category" : "Missile",
		"pack_cost" : 50
	},
	"FlameThrower":{
		"unlocked" : false,
		"cost" : 20,
		"damage" : 0.5,
		"rof" : 0,
		"range" : 200,
		"category" : "Missile",
		"pack_cost" : 50
	},
	"CrossBow":{
		"unlocked" : false,
		"cost" : 25,
		"damage" : 25,
		"rof" : 1.2,
		"range" : 300,
		"category" : "Arrow",
		"pack_cost" : 50
	},
	"TeslaCoil":{
		"unlocked" : false,
		"cost" : 10,
		"damage" : 10,
		"rof" : 0.6,
		"range" : 500,
		"category" : "Zap",
		"pack_cost" : 50
	},
	"CrossBowPacked":{
		"cost" : 50,
		"damage" : 25,
		"rof" : .8,
		"range" : 400,
		"category" : "Arrow",
		"pack_cost" : 50
	},
	"GunI":{
		"cost" : 30,
		"damage" : 35,
		"rof" : .5,
		"range" : 500,
		"category" : "Bullet",
		"pack_cost" : 50
	},
	"GunII": {
		"damage" : 40,
		"rof" : 0.3,
		"range" : 400,
		"category" : "Physical",
		"cost" : 50},
	"Mortar": {
		"unlocked" : false,
		"damage" : 35,
		"range": 450,
		"rof" : 3.5,
		"category" : "Artillery",
		"cost" : 30}
}
		
var enemy_data = {
	"Zombie_Normal":{
		"health" = 100,
		"damage" = 1,
		"value" = 10,
		"speed" = 150
	},
	"Zombie_Hazmat":{
		"health" = 200,
		"damage" = 5,
		"value" = 20,
		"speed" = 100
	},
	"Zombie_Crawler":{
		"health" = 200,
		"damage" = 2,
		"value" = 20,
		"speed" = 80
	},
	"HellHound":{
		"health" = 50,
		"damage" = 3,
		"value" = 10,
		"speed" = 350
	},
}

var wave_data = {
	"Map1": {
		"wave_count": 4,
		"Wave1" : [
			["Zombie_Normal",3],
			["HellHound",1],
			["Zombie_Normal",1],
			["HellHound",1],
			["Zombie_Hazmat",1]
			],
		"Wave2" : [
			["Zombie_Hazmat",2],
			["Zombie_Normal",2],
			["Zombie_Crawler",6],
			["Zombie_Crawler",1],
			["Zombie_Normal",2],
			["Zombie_Hazmat",3]
			],
		"Wave3" : [
			["HellHound", 0.2], 
			["HellHound", 0.3], 
			["HellHound", 0.13], 
			["HellHound", 0.2],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			],
		"Wave4" : [
			["Zombie_Hazmat",2],
			["Zombie_Hazmat",2],
			["Zombie_Normal",6],
			["Zombie_Normal",1],
			["Zombie_Crawler",1],
			["Zombie_Crawler",1],
			["Zombie_Hazmat",2],
			["Zombie_Normal",2],
			["Zombie_Normal",2],
			["Zombie_Hazmat",6],
			["Zombie_Crawler",1],
			["Zombie_Normal",1],
			["Zombie_Normal",2]
			],
		"Wave5" : [
			["Zombie_Normal",2],
			["Zombie_Hazmat",2],
			["Zombie_Normal",6],
			["Zombie_Hazmat",1],
			["Zombie_Hazmat",2],
			["Zombie_Hazmat",2],
			["Zombie_Normal",2],
			["Zombie_Crawler",6],
			["Zombie_Crawler",1],
			["Zombie_Normal",2]
			]
		},
	"Map2": {
		"wave_count": 4,
		"Wave1" : [
			["Zombie_Normal",3],
			["HellHound",1],
			["Zombie_Normal",1],
			["HellHound",1],
			["Zombie_Hazmat",1]
			],
		"Wave2" : [
			["Zombie_Hazmat",2],
			["Zombie_Normal",2],
			["Zombie_Crawler",6],
			["Zombie_Crawler",1],
			["Zombie_Normal",2],
			["Zombie_Hazmat",3]
			],
		"Wave3" : [
			["Zombie_Hazmat",2],
			["Zombie_Hazmat",2],
			["Zombie_Normal",6],
			["Zombie_Normal",1],
			["Zombie_Hazmat",2],
			["Zombie_Crawler",2],
			["Zombie_Crawler",2],
			["Zombie_Hazmat",6],
			["Zombie_Crawler",1],
			["Zombie_Normal",2]
			],
		"Wave4" : [
			["HellHound", 0.2], 
			["HellHound", 0.3], 
			["HellHound", 0.13], 
			["HellHound", 0.2],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			],
		"Wave5" : [
			["Zombie_Normal",2],
			["Zombie_Normal",2],
			["Zombie_Crawler",6],
			["Zombie_Crawler",1],
			["Zombie_Crawler",2],
			["Zombie_Normal",2],
			["Zombie_Normal",2],
			["Zombie_Normal",6],
			["Zombie_Normal",1],
			["Zombie_Normal",2]
			]
		},
	"MapTutorial": {
		"wave_count": 4,
		"Wave1" : [
			["Zombie_Normal",3],
			["HellHound",1],
			["Zombie_Normal",1],
			["HellHound",1],
			["Zombie_Hazmat",1]
			],
		"Wave2" : [
			["Zombie_Hazmat",2],
			["Zombie_Normal",2],
			["Zombie_Crawler",6],
			["Zombie_Crawler",1],
			["Zombie_Normal",2],
			["Zombie_Hazmat",3]
			],
		"Wave3" : [
			["Zombie_Hazmat",2],
			["Zombie_Hazmat",2],
			["Zombie_Normal",6],
			["Zombie_Normal",1],
			["Zombie_Hazmat",2],
			["Zombie_Crawler",2],
			["Zombie_Crawler",2],
			["Zombie_Hazmat",6],
			["Zombie_Crawler",1],
			["Zombie_Normal",2]
			],
		"Wave4" : [
			["HellHound", 0.2], 
			["HellHound", 0.3], 
			["HellHound", 0.13], 
			["HellHound", 0.2],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			["HellHound", 1], 
			["HellHound", 0.2], 
			["HellHound", 0.3],
			],
		"Wave5" : [
			["Zombie_Normal",2],
			["Zombie_Normal",2],
			["Zombie_Crawler",6],
			["Zombie_Crawler",1],
			["Zombie_Crawler",2],
			["Zombie_Normal",2],
			["Zombie_Normal",2],
			["Zombie_Normal",6],
			["Zombie_Normal",1],
			["Zombie_Normal",2]
			]
		}
	
	}
	
var campaign_progress_data = {
	"MapTutorial" : ["Unlocked", "Incomplete"],
	"Map1" : ["Locked", "Incomplete"],
	"Map2" : ["Locked", "Incomplete"]
}

