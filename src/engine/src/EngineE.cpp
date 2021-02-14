
#include "EngineE.h"

#include <cassert>
#include <vector>

#include "DebugE.h"
#include "iostream"

std::array<SquareE, G2::BoardSize>                   Sq;
std::array<PieceE, G2::MAX_PLAYERS * G2::MAX_PIECES> Pp;  // PlayerPiece
vector<MoveE>                                        MoveStack;
void PushMove( MoveE mv ) { MoveStack.push_back( mv ); }

using std::cout;

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
int man()
{
    InitBoardE();
    // DebugE::zDebugMoveFunctions();

    // ranPrint();
    return 0;
}
int turn = 0;

MoveE OnPieceClicked( const u64 pl, const u64 pi )
{
    /// DebugE::PrintPieceArray();
    // init data-------------------------------------
    assert( pl < G2::MAX_PLAYERS && pi < G2::MAX_PIECES );
    const int Roll = 1;
    MoveE     Mv;
    const u64 i    = PieceE::GetPPnum( pl, pi );
    const u64 From = Pp[i].Sq();
    u64       To   = 0;
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
    if ( From < 52 )
    {
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
        for ( int q = 0; q < G2::MAX_PLAYERS; q++ )
        {
            if ( Sq[To].Pl( q ) != 0 && q != pl )
            {
                Mv.IsCap( 1 );
                Mv.CPl( q );
                Mv.PBits( Sq[To].Pl( q ) );

                for ( int k = 0; k < G2::MAX_PIECES; k++ )
                {
                    if ( Sq[To].PP( q, k ) != 0 )
                    {
                        u64 j = PieceE::GetPPnum( q, k );
                        Pp[j].Sq( G2::START_POSI );
                        Sq[To].PopPP( q, k );
                        Sq[G2::START_POSI].PushPP( q, k );
                    }
                }
            }
        }
    }

    // no cap case
    // adjust player
    // move base-------------------------------------
    Pp[i].Sq( To );
    Sq[From].PopPP( i );
    Sq[To].PushPP( i );
    // update move -------------------------------
    Mv.From( From );
    Mv.To( To );
    Mv.Pl( pl );
    Mv.Pi( pi );

    //  DebugE::DisplaySquares();
    // DebugE::DisplayPMove( Mv );

    // no cap as

    // Mv.CheckMove();
    // TODO: push move to stack

    return Mv;
}

void MoveTo() {}
