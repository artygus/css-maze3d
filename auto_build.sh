#!/bin/sh

coffee -o compiled/ -c -w *.coffee &
coffee -o level_editor/compiled/ -c -w level_editor/*.coffee &
coffee -o game_logic/compiled -c -w game_logic/*.coffee &
coffee -o compiled/ -c -w utils/*.coffee &
coffee -o compiled/ -c -w data_types/*.coffee