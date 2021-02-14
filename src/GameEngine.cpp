
#include <bits/stdint-intn.h>
#include <sys/types.h>

#include "GameEngine.h"

using namespace godot;

//#define Mpp( pl, pi, sq ) DBoard->call( "MovePP_TO", pl, pi, sq )
    
void GameEngine::_ready()
{
    man();
}


void GameEngine::ApplyMove( MoveE mv )
{   // DebugE::DisplaySquares();
    godot::Array move;

    move.clear();
    Moves.clear();
    move.resize(3);    
    //Mpp( mv.Pl(), mv.Pi(), mv.To() );
    move[0]=mv.Pl();
    move[1]=mv.Pi();
    move[2]=mv.To();
 
    Moves.append(move);
    if ( mv.IsCap() == 1 ) {
        int player = mv.CPl();

        for ( u64 i = 0; i < 4; i++ ) {
            if ( ( ( mv.PBits() >> i ) & (u64)1 ) != 0 ) {
               // Mpp( player, i, 72 );
                //std::cout<<"i is :" <<i<<" player is "<<player<<"\n";
                //wow man is this waht you want
                godot::Array chut;
                chut.clear();
                chut.resize(3);
                chut[0]=player;
                chut[1]=i;
                chut[2]=72;
                Moves.append(chut);
            
            }
        }
    }
}

void GameEngine::_register_methods()
{
    register_method( "_process", &GameEngine::_process );
    register_method( "_ready", &GameEngine::_ready );
    register_method( "InputClicked", &GameEngine::InputClicked );
    register_method("GetMoves",&GameEngine::GetMoves);
}

godot::Array GameEngine::GetMoves(){
    //return 123;
    /*
   Mpp( mv.Pl(), mv.Pi(), mv.To() );

    if ( mv.IsCap() == 1 ) {
        int player = mv.CPl();

        for ( u64 i = 0; i < 4; i++ ) {
            if ( ( ( mv.PBits() >> i ) & (u64)1 ) != 0 ) {
                Mpp( player, i, 72 );
            }
        }
    }*/
 

    return Moves;
 
}
void GameEngine::InputClicked( int player, int piece )
{
  //  Godot::print("fff");

      std::string s1 = "Player: " + std::to_string( player ) +
                     " Piece: " + std::to_string( piece );

    //  const char *wow = s1.c_str();
     //Godot::print( wow );

    MoveE tt;
    tt=OnPieceClicked(player, piece);
    

    ApplyMove( tt );
   // DebugE::DisplayPMove(test);
}

void GameEngine::_init()
{
    // quick_exit(12);
}

void GameEngine::_process() {}





