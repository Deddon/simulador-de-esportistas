extends Node


enum SportsmanAvailableSports {
	NULL,
	OLYMPIC_WEIGHT_LIFTER,
	LONG_RUNNER,
	FOUR_HUNDRED_METERS_RUNNER
}


const AvailableSportsMet = [
	0.0, # Null
	6.0, # LPO - Resistance (weight lifting - free weight, nautilus or universal-type), power lifting or body building, vigorous effort (Taylor Code 210)
	11.0, # Long Run - Running, 7 mph (8.5 min/mile)
	10.0 # Speed Run - Running, on a track, team practic
]
