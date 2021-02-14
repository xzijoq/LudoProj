#include "CoreE.h"

#include <cassert>
#include <iostream>

//#include "DeclarationsE.h"


using std::cout;
static constexpr int Mpl = G2::MAX_PLAYERS;
static constexpr int Mpi = G2::MAX_PIECES;
static constexpr int Mpp = Mpl * Mpi;
static const int     Bsz = G2::BoardSize;

void PieceE::InitPieceE( u64 sq, u64 inSq, u64 endSq, u64 swiSq, u64 plNum,
                         u64 pieNum )
{
    Sq( sq );
    InSq( inSq );
    EndSq( endSq );
    SwiSq( swiSq );
    Pnum( plNum );
    PieNum( pieNum );
}
void PieceE::CheckPiece()
{
    assert( Sq() < Bsz );

    /*only required afer init
    assert( InSq() < Bsz );
    assert( EndSq() < Bsz );
    assert( SwiSq() < Bsz );
    assert( PieNum() < Bsz );

    //kindka useless
    assert( PieNum() < Mpi );
    assert(Pnum()<Mpl);
    assert( PPnum() <Mpp );
*/
}

void SquareE::CheckSquare()
{
    for ( int i = 0; i < Mpl; i++ )  // will be kinda trivially true
    {
        assert( Pl( i ) < Mpp );
    }
}

void MoveE::CheckMove()
{
    assert( From() < Bsz );
    assert( To() < Bsz );

    if ( From() == To() ) {
        std::cout << "\nFrom And To are same in this Move\n";
    }

    /* kinda useless
    assert(PP()<Mpp);
    assert(Pl()<Mpl);
    assert(Pi()<Mpi);
    */
}

void BitsE::DisplayBits( int sp )
{
    for ( auto i = 63; i >= 0; i-- ) {
        ( PInt & 1ULL << i ) ? cout << 1 : cout << 0;
        if ( ( i ) % sp == 0 ) { cout << " "; }
        if ( ( i ) % 4 == 0 && sp == 8 ) { cout << " "; }
    }
}
