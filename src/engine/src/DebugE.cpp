#include "DebugE.h"

#include <bitset>
#include <iostream>
#include "EngineE.h"
#include "CoreE.h"

using std::cout;

void DebugE::PrintPieceArray()
{
    cout << "\n";
    for ( int i = 0; i < G2::MAX_PP; i++ ) {
        Pp[i].DisplayBits( 7 );
        cout << "\n";
    }

    for ( int i = 0; i < G2::MAX_PP; i++ ) {
        cout<<"\n"<<"PP: "<<PieceE::GetPPnum(Pp[i].Pnum(),  Pp[i].PieNum());
        cout << " PlN: " << Pp[i].Pnum() << " PieN: " << Pp[i].PieNum()
             << " SwiSq: " << Pp[i].SwiSq() << " EndSq: " << Pp[i].EndSq()
             << " InSq: " << Pp[i].InSq() << " Sq: " << Pp[i].Sq();
    }
    cout << "\n";
}
void DebugE::zDebugPieceFunctions()
{
    PieceE test;
    cout << "\n-----------TestStart-------";
    test.Sq( 0b1000011 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.InSq( 0b1000101 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.EndSq( 0b1001001 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.SwiSq( 0b1010001 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.Pnum( 0b11 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.PieNum( 0b01 );
    test.DisplayBits( 7 );
    cout << "\n";

    cout << "\n----------GetTestStart -----------\n";

    DebugE::DisplayBits( test.Sq(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.InSq(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.EndSq(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.SwiSq(), 7 );
    cout << "\n";

    DebugE::DisplayBits( test.Pnum(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.PieNum(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.PPnum(), 7 );
    cout << "\n";
}
void DebugE::DisplayBits( u64 num, int sp, bool val )
{
    cout << "\n";
    for ( auto i = 63; i >= 0; i-- ) {
        if ( val ) {
            std::cout << ( num & 1ULL << i ) << " ";
        } else {
            ( num & 1ULL << i ) ? cout << 1 : cout << 0;
        }
        if ( ( i ) % sp == 0 ) { cout << " "; }
        if ( ( i ) % 4 == 0 && sp == 8 ) { cout << " "; }
    }
    cout << "\n";
}

void DebugE::zDebugMoveFunctions()
{
    MoveE test;

    cout << "\n-----------SetTestStart-------\n";
    test.From( 0b1000011 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.To( 0b1000101 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.PP( 0b1001 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.IsCap( 0b1 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.CPl( 0b10 );
    test.DisplayBits( 7 );
    cout << "\n";

    test.PBits( 0b1001 );
    test.DisplayBits( 7 );
    cout << "\n";
    test.CPiece( 1 );
    test.DisplayBits( 7 );
    cout << "\n";
    cout << "\n----------GetTestStart -----------\n";

    DebugE::DisplayBits( test.From(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.To(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.PP(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.IsCap(), 7 );
    cout << "\n";

    DebugE::DisplayBits( test.CPl(), 7 );
    cout << "\n";
    DebugE::DisplayBits( test.PBits(), 7 );
    cout << "\n";
}

void DebugE::zDebugSqFunctions()
{
    SquareE test;
    test.PushPP( 1, 1 );
    test.DisplayBits();
    cout << "\n";
    test.PushPP( 6 );
    test.DisplayBits();
    cout << "\n";
    test.PopPP( 6 );
    test.DisplayBits();
    cout << "\n";
    test.PopPP( 1, 1 );
    test.DisplayBits();
    cout << "\n";

    test.PushPP( 7 );
    test.PushPP( 4 );
    test.DisplayBits();
    cout << "\n";
    DebugE::DisBits( 4, test.Pl( 1 ) );
    cout << "\n";
    DebugE::DisBits( 2, test.PP( 7 ) );
    cout << " ";
    DebugE::DisBits( 2, test.PP( 4 ) );
    cout << " ";
    DebugE::DisBits( 2, test.PP( 5 ) );
    cout << " \n";

    DebugE::DisBits( 2, test.PP( 1, 3 ) );
    cout << " ";
    DebugE::DisBits( 2, test.PP( 1, 0 ) );
    cout << " ";
    DebugE::DisBits( 2, test.PP( 1, 1 ) );
    cout << " ";
}

void DebugE::DisplayPMove( MoveE mv )
{
    cout << "\nfrm:" << mv.From() << " to:" << mv.To() << " pl:" << mv.Pl()
         << " pi:" << mv.Pi() << " C?:" << mv.IsCap() << " plC:" << mv.CPl();
    cout << " CaPie:";
    for ( int i = 3; i >= 0; i-- ) {
        ( mv.PBits() & 1ULL << i ) ? cout << 1 : cout << 0;
    }
    cout << "\n";
}

void DebugE::DisplaySquares()
{
    for ( int i = 0; i < Sq.size(); i++ ) {
        for ( int j = 0; j < G2::MAX_PIECES; j++ ) {
            if ( Sq[i].Pl( j ) != 0 ) {
                cout << "\nSquare " << i << " is: ";
                Sq[i].DisplayBits();
                break;
            }
        }
    }
}

void DebugE::DisBits( u64 count, u64 num )
{
    for ( int i = count - 1; i >= 0; i-- ) {
        ( num & 1ULL << i ) ? cout << 1 : cout << 0;
    }
}
