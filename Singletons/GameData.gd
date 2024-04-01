extends Node


var tower_data = {
	"Gun":{
		"cost" : 25,
		"damage" : 10,
		"rof" : 1,
		"range" : 350,
		"category" : "Bullet"},
	"Missile":{
		"cost" : 50,
		"damage" : 20,
		"rof" : 1.5,
		"range" : 750,
		"category" : "Missile"},
	"CrossBow":{
		"cost" : 25,
		"damage" : 20,
		"rof" : 1,
		"range" : 350,
		"category" : "Arrow"},
	"TeslaCoil":{
		"cost" : 25,
		"damage" : 10,
		"rof" : 0.6,
		"range" : 350,
		"category" : "Zap"},
	"CrossBowPacked":{
		"cost" : 50,
		"damage" : 50,
		"rof" : .8,
		"range" : 350,
		"category" : "Arrow"},
	"GunPacked":{
		"cost" : 25,
		"damage" : 10,
		"rof" : 1,
		"range" : 350,
		"category" : "Bullet"
		}
}
		
var enemy_data = {
	"Zombie_Normal":{
		"health" = 50,
		"damage" = 25,
		"value" = 25,
		"speed" = 150
	},
	"Zombie_Hazmat":{
		"health" = 100,
		"damage" = 5,
		"value" = 100,
		"speed" = 75
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
		"Wave1" = [["Zombie_Normal", 0.7], ["Zombie_Normal", 1.2], ["Zombie_Normal", 2.0], ["Zombie_Hazmat", 2.5], ["Zombie_Hazmat", 5.0]],
		"Wave2" = [["Zombie_Normal", 0.5], ["Zombie_Normal", 1], ["Zombie_Normal", 1.5], ["Zombie_Normal", 2.0], ["Zombie_Hazmat", 2.5],["Zombie_Hazmat", 3], ["Zombie_Hazmat", 3.5]],
		"Wave3" = [["Zombie_Normal", 0.7], ["Zombie_Normal", 1.2], ["Zombie_Normal", 2.0], ["Zombie_Hazmat", 2.5], ["Zombie_Hazmat", 5.0]],
		"Wave4" = [["Zombie_Normal", 0.7], ["Zombie_Normal", 1.2], ["Zombie_Normal", 2.0], ["Zombie_Hazmat", 2.5], ["Zombie_Hazmat", 5.0]],
		
		
	}
}
