
extends Node


const MAX_ROW     :int= 15;
const MAX_COL     :int= 15;
const MAX_PLAYERS :int= 4;
const MAX_PIECES  :int= 4;
const START_POSI  :int= 72;
const END_POSI    :int= 73;
const OUTER_SZ    :int= 52;


const MAX_PP :int= MAX_PIECES * MAX_PLAYERS;

const SafeSq       = [ 3,  11, 16, 24,         29,
                                37, 42, 50, START_POSI, END_POSI ];
const StartSq      = [ 3, 16, 29, 42 ];
const SwitchSq     = [ 1, 14, 27, 40 ];
const SwitchIntoSq = [ 52, 57, 62, 67 ];
const EndSq        = [ 56, 61, 66, 71 ];




	



#can implement on viiewport resize