# Drone-X
This repository contains a parser built using Lex & Yacc for my langauge, DroxeX.
DroxeX is designed for programming drones.

## Features
* A gyroscope that detects the inclination of the drone, a barometer for measuring altitude and a thermometer that measures changes in temperature, an acceleration sensor.
* A video camera that can be turned on and off, or it can be used to take pictures.
* Connection to the base computer through wi-fi. The base computer may be a desktop or a mobile device.
## Contents
* droneX.lex: Lex specification file, Lexical Analyzer to tokenize the input.
* droneX.yacc: Yacc specification file, Parser to check acceptance of the input.
* Makefile: Running DroneX test file to check whether test file represents a valid program.
* Report.pdf: Report explaining the tokens and complete BNF description of the DroneX language.
