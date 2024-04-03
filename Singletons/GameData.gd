extends Node


var tower_data = {
	"Gun":{
		"cost" : 25,
		"damage" : 25,
		"rof" : 1,
		"range" : 400,
		"category" : "Bullet"},
	"Missile":{
		"cost" : 25,
		"damage" : 25,
		"rof" : 1.5,
		"range" : 500,
		"category" : "Missile"},
	"CrossBow":{
		"cost" : 25,
		"damage" : 25,
		"rof" : 1.2,
		"range" : 300,
		"category" : "Arrow"},
	"TeslaCoil":{
		"cost" : 100,
		"damage" : 10,
		"rof" : 0.6,
		"range" : 500,
		"category" : "Zap"},
	"CrossBowPacked":{
		"cost" : 50,
		"damage" : 25,
		"rof" : .8,
		"range" : 400,
		"category" : "Arrow"},
	"GunPacked":{
		"cost" : 25,
		"damage" : 35,
		"rof" : .5,
		"range" : 500,
		"category" : "Bullet"
		}
}
		
var enemy_data = {
	"Zombie_Normal":{
		"health" = 100,
		"damage" = 25,
		"value" = 10,
		"speed" = 150
	},
	"Zombie_Hazmat":{
		"health" = 200,
		"damage" = 50,
		"value" = 20,
		"speed" = 100
	},
	"HellHound":{
		"health" = 50,
		"damage" = 25,
		"value" = 10,
		"speed" = 200
	},
	"RedTank":{
		"health" = 100,
		"damage" = 25,
		"value" = 50,
		"speed" = 75
	}
}

var wave_data = {
		"Map1":{
		"Wave1" = 
			[["HellHound", 0], ["HellHound", 1]],
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
	

