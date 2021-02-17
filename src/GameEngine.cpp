#include "GameEngine.h"

#include <bits/stdint-intn.h>
#include <sys/types.h>

#include "Array.hpp"
#include "CoreE.h"
#include "DebugE.h"

using namespace godot;

void GameEngine::_ready() { man(); }

godot::Array GameEngine::GetValidInp()
{
    ValidInp.clear();
    ValidInput vi;
    vi = GetValidInputs( 1 );
    // DebugE::DisplayValidInput(vi);
    ValidInp.append( vi.Error() );
    ValidInp.append( vi.Roll() );
    ValidInp.append( vi.Pl() );
    for ( auto i = 0; i < 4; i++ ) { ValidInp.append( vi.HasPi( i ) ); }

    return ValidInp;
}

godot::Array GameEngine::PGclicked( int pl, int go )
{
    vector<MoveE> mv;
    mv = OnPC( pl, go );

    // move.clear();

    Moves.clear();
    for ( auto i = 0; i < mv.size(); i++ )
    {
        godot::Array move;
        move.clear();
        move.resize( 3 );
        move[0] = mv[i].Pl();
        move[1] = mv[i].Pi();
        move[2] = mv[i].To();
        Moves.append( move );
    }
    //for ( auto i : mv ) { DebugE::DisplayPMove( i );
    //std::cout<<mv.size(); }
    EndTurn();
    return Moves;
}
godot::Array GameEngine::GetMoves() { return Moves; }

void GameEngine::InputClicked( int player, int piece )
{  // DebugE::DisplayPMove(test);
}

void GameEngine::_init()
{
    // quick_exit(12);
}

void GameEngine::_process() {}

void GameEngine::_register_methods()
{
    register_method( "_process", &GameEngine::_process );
    register_method( "_ready", &GameEngine::_ready );
    register_method( "InputClicked", &GameEngine::InputClicked );
    register_method( "GetMoves", &GameEngine::GetMoves );
    register_method( "PGclicked", &GameEngine::PGclicked );
    register_method( "GetValidInp", &GameEngine::GetValidInp );
}
