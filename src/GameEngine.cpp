#include "GameEngine.h"

//#include <bits/stdint-intn.h>
#include <sys/types.h>
#include <iostream>

#include "Array.hpp"
#include "CoreE.h"
#include "DebugE.h"
#include "GData.h"
#include "Godot.hpp"

using namespace godot;




//void GameEngine::_ready() {}
void GameEngine::StartGame(){
    man();
}
godot::Array GameEngine::GetValidInp()
{
    ValidInp.clear();
    ValidInput vi;
    u64 cry = GetValidInputs( 1 );
    vi.PInt=cry;

    // DebugE::DisplayValidInput(vi);
    ValidInp.append( vi.Error() );
    ValidInp.append( vi.Roll() );
    ValidInp.append( vi.Pl() );
    for ( auto i = 0; i < 4; i++ ) { ValidInp.append( vi.HasPi( i ) ); }

    return ValidInp;
}

godot::Array GameEngine::PGclicked( int pl, int go )
{
    vector<u64> mv;
    mv = OnPC( pl, go );

    // move.clear();

    Moves.clear();
    for ( auto i = 0; i < mv.size(); i++ )
    {
        MoveE mvP;
        mvP.PInt=mv[i];
        godot::Array move;
        move.clear();
        move.resize( 3 );
        move[0] = mvP.Pl();
        move[1] = mvP.Pi();
        move[2] = mvP.To();
        Moves.append( move );
    }
    //for ( auto i : mv ) { DebugE::DisplayPMove( i );}
    //std::cout<<mv.size(); }
   // EndTurn();
    return Moves;
}



void GameEngine::EndTurnE(){
    EndTurnM();
}

void GameEngine::StartTurnE(int player){
    StartTurn();
}


godot::Array GameEngine::GetSquare(int sq){

    godot::Array pg;

    for (auto pl =0;pl<G2::MAX_PLAYERS;pl++){
        for (auto pie=0;pie<G2::MAX_PIECES;pie++){
            if (Sq[sq].PP(pl,pie)!=0){
                   godot::Array pp;
                   pp.clear();
                   pp.append(pl);
                   pp.append(pie);
                   pg.append(pp);
            }
        }
    }

    return pg;
}
godot::Array GameEngine::GetMoves() { 
    

    return Moves; }



void GameEngine::_init()
{
    // quick_exit(12);
}



void GameEngine::_register_methods()
{

 
    register_method( "GetMoves", &GameEngine::GetMoves );
    register_method( "PGclicked", &GameEngine::PGclicked );
    register_method( "GetValidInp", &GameEngine::GetValidInp );
    register_method("EndTurnE", &GameEngine::EndTurnE);
    register_method("StartGame", &GameEngine::StartGame);
    register_method("GetSquare", &GameEngine::GetSquare);
}
