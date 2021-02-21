#include "EngineE.h"

#include <cassert>
#include <exception>
#include <vector>

#include "CoreE.h"
#include "DebugE.h"
#include "GData.h"
#include "iostream"
using std::cout;

std::array<SquareE, G2::BoardSize>                   Sq;
std::array<PieceE, G2::MAX_PLAYERS * G2::MAX_PIECES> Pp;  // PlayerPiece
vector<MoveE>                                        MoveStack;
vector<u64> MoveList;  // TODO need to not resize so many times
int         EndTurn();
int         TurnNumber = 0;
int         RollG      = 1;
ValidInput  OutVIn;

enum TurnS
{
    Player0S,
    Player1S,
    Player2S,
    Player3S
};
TurnS CurrentTurn;

void PushMove( MoveE mv ) { MoveStack.push_back( mv ); }

int StartTurn()
{
    // if ( CurrentState != InitTurnS ) { return -CurrentState; }
    TurnNumber++;

    // std::cout << "current Turn player: " << CurrentTurn << "\n";
    MoveList.clear();

    return 0;
}

u64 GetValidInputs( int roll )
{
    RollG = roll;

    OutVIn.Clear();
    OutVIn.Roll( RollG );
    OutVIn.Pl( CurrentTurn );

    for ( auto piece = 0; piece < G2::MAX_PIECES; piece++ )
    {
        u64 pp = PieceE::GetPPnum( CurrentTurn, piece );

        // if ( Pp[pp].Sq() != G2::START_POSI &&
        if ( Pp[pp].Sq() + RollG < Pp[pp].EndSq() ) { OutVIn.Pi( piece ); }
        if ( ( RollG == 6 || RollG == 1 ) && Pp[pp].Sq() == G2::START_POSI )
        { OutVIn.Pi( piece ); }
    }

    return OutVIn.PInt;
}

// currently OnPc need more for powers
// add move powers here

vector<u64> OnPC( const u64 pl, const u64 pi )
{
    // MoveList.clear();
    /// DebugE::PrintPieceArray();
    // init data-------------------------------------
    assert( pl < G2::MAX_PLAYERS && pi < G2::MAX_PIECES );
    const int Roll = RollG;
    MoveE     Mv;
    const u64 i    = PieceE::GetPPnum( pl, pi );
    const u64 From = Pp[i].Sq();
    u64       To   = 0;

    // DebugE::DisplayValidInput(OutVIn);

    // Verify ValidInput
    if ( ( pl != OutVIn.Pl() ) && ( !OutVIn.HasPi( pi ) ) )
    {
        std::cout << "\nInvalidIputClientHacked\n";
        // return MoveList;
    }

    // TODO :validate move
    // cout<<"\nthis : "<<Pp[i].Sq()<<"\n";
    // Start Sq-----------------------------
    if ( Pp[i].Sq() == G2::START_POSI ) { To = G2::StartSq[pl]; }
    // else
    else if ( From < Pp[i].InSq() )
    {
        To = ( From + Roll ) % G2::OUTER_SZ;
    }
    else
    {
        To = ( From + Roll );
    }

    // Switch into safe zone---------------------
    if ( From < G2::OUTER_SZ )
    {  // if in the path from->to if find insq swithc into it
        int tTo = To;

        for ( int z = From, y = 0; z != tTo; z = ( z + 1 ) % G2::OUTER_SZ )
        {
            if ( Pp[i].SwiSq() == z )
            {
                // calculate the moves left
                int movesLeft = Roll - y - 1;
                To            = Pp[i].InSq() + movesLeft;
            }
            y++;
        }
    }

    // END----------------------------------
    if ( To > Pp[i].EndSq() ) { To = G2::END_POSI; }

    // capture------------------------------------------
    if ( !Sq[To].IsSafe() )
    {
        for ( int player = 0; player < G2::MAX_PLAYERS; player++ )
        {
            if ( Sq[To].Pl( player ) != 0 && player != pl )
            {
                MoveE cMv;
                cMv.IsCap( 1 );
                Mv.IsCap( 1 );
                Mv.CPl( player );
                Mv.PBits( Sq[To].Pl( player ) );
                // send all pieces home
                for ( int piece = 0; piece < G2::MAX_PIECES; piece++ )
                {
                    if ( Sq[To].PP( player, piece ) != 0 )
                    {
                        u64 j = PieceE::GetPPnum( player, piece );

                        Pp[j].Sq( G2::START_POSI );
                        Sq[To].PopPP( player, piece );
                        Sq[G2::START_POSI].PushPP( player, piece );

                        cMv.Pl( player );
                        cMv.Pi( piece );
                        cMv.From( To );
                        cMv.To( G2::START_POSI );
                        MoveList.push_back( cMv.PInt );
                        // DebugE::DisplayPMove(cMv);
                    }
                }
            }
        }
    }

    // no cap case
    // adjust player

    auto UpdateMove = [&]() {
        Mv.From( From );
        Mv.To( To );
        Mv.Pl( pl );
        Mv.Pi( pi );
    };
    auto MoveBase = [&]() {
        Pp[i].Sq( To );
        Sq[From].PopPP( i );
        Sq[To].PushPP( i );
    };
    // move base-------------------------------------
    MoveBase();
    // update move -------------------------------

    UpdateMove();
    //  DebugE::DisplaySquares();
    // DebugE::DisplayPMove( Mv );
    MoveList.push_back( Mv.PInt );
    // no cap as

    // Mv.CheckMove();
    // TODO: push move to stack
    // EndTurn();
    return MoveList;
}

int EndTurnM()
{
    // Calling this will clear MoveList via a call to initmove

    // if ( CurrentState != MakeMoveS ) { return -CurrentState; }
    int NextPlayer = CurrentTurn;
    // endturn
    // push MoveTOstack for roll back
    if ( RollG != 6 )
    {
        NextPlayer = ( NextPlayer + 1 ) % 4;
        // if (NextPlayer==0){NextPlayer=3;}
        // else{NextPlayer=0;}
    }

    // NextPlayer=0;
    // cout << "turn Ended\n";
    CurrentTurn = (TurnS)NextPlayer;

    StartTurn();
    return 0;
}

int man()
{
    CurrentTurn = Player0S;
    // ValidInput in;

    InitBoardE();
    return 0;
}
void InitBoardE()
{
    for ( int i = 0; i < G2::MAX_PLAYERS; i++ )
    {
        for ( int j = 0; j < G2::MAX_PIECES; j++ )
        {
            Pp[i * G2::MAX_PIECES + j].InitPieceE(
                G2::START_POSI, G2::SwitchIntoSq[i], G2::EndSq[i],
                G2::SwitchSq[i], i, j );
            Sq[G2::START_POSI].PushPP( i, j );
        }
    }
    for ( auto i : G2::SafeSq ) { Sq[i].SetSafe(); }
}

int main3()
{
    InitBoardE();
    cout << "fuck\n";
    Sq[2].PushPP( 1, 1 );
    Sq[2].PushPP( 1, 0 );
    Sq[2].PushPP( 1, 3 );

    Sq[2].Pl( 1 );
    MoveE test;
    test.PBits( Sq[2].Pl( 1 ) );

    BitsE tt;
    tt.SetBit( 61 );

    tt.SetBit( 12 );
    tt.DisplayBits();
    cout << "\n";
    test.DisplayBits( 7 );
    // cout<<"lsize is: "<<G2::LudoBoard.size();
    return 0;
}
