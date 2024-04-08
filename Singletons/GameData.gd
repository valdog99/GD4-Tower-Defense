extends Node


var tower_data = {
	"Gun":{
		"cost" : 25,
		"damage" : 25,
		"rof" : 1,
		"range" : 400,
		"category" : "Bullet",
		"pack_cost" : 50
	},
	"Missile":{
		"cost" : 25,
		"damage" : 25,
		"rof" : 1.5,
		"range" : 500,
		"category" : "Missile",
		"pack_cost" : 50
	},
	"FlameThrower":{
		"cost" : 20,
		"damage" : 0.5,
		"rof" : 0,
		"range" : 200,
		"category" : "Missile",
		"pack_cost" : 50
	},
	"CrossBow":{
		"cost" : 25,
		"damage" : 25,
		"rof" : 1.2,
		"range" : 300,
		"category" : "Arrow",
		"pack_cost" : 50
	},
	"TeslaCoil":{
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
	"GunPacked":{
		"cost" : 25,
		"damage" : 35,
		"rof" : .5,
		"range" : 500,
		"category" : "Bullet",
		"pack_cost" : 50
	}
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
		"Map1":{
		"Wave1" = 
			[["Zombie_Crawler", 5], 
			["Zombie_Crawler", 7],
			["Zombie_hazmat", 8],
			["Zombie_hazmat", 9],
			["HellHound", 10],
			],
		"Wave2" = 
			[],
		"Wave3" = 
			[],
		"Wave4" = 
			[],
		"Wave5" = 
			[]
		}
	}
	

