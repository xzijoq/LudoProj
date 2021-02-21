#pragma once

//#include "DebugE.h"
#include "GData.h"

class BitsE
{
   public:
    u64                  PInt{ 0 };
    static constexpr u64 pow[]{
        0b0,     0b1,      0b11,      0b111,     0b1111,  // wow
        0b11111, 0b111111, 0b1111111, 0b11111111

    };

    BitsE() : PInt{ 0 } {}

   public:
    void        DisplayBits( int sp = 8 );
    inline u64  GetBit( u64 bit ) { return ( ( PInt >> bit ) & (u64)1 ); }
    inline void SetBit( u64 bit ) { PInt |= (u64)1 << bit; }
    inline void UnSetBit( u64 bit ) { PInt &= ~( (u64)1 << bit ); }

    inline void SetBits( u64 count, u64 bits, u64 posi )
    {
        // should send some error possibly via return type
        if ( bits > pow[count] ) { bits = pow[count]; }

        // clear those bits to zero and set new
        PInt &= ~( pow[count] << posi );

        PInt |= bits << posi;
    }
    inline u64 GetBits( u64 count, u64 posi )
    {
        return ( PInt >> posi ) & pow[count];
    }

    inline u64 ToInt() { return PInt; }
};

//  PPnum(4 (0-16)) //Switch Into 7// EndSq 7// InSq 7// Square 7
//  32-30       28            21        14         7       0
class PieceE : public BitsE
{
   public:
    static inline u64 GetPPnum( u64 pl, u64 pi )
    {
        return ( pl * G2::MAX_PIECES + pi );
    }
    inline u64 Sq() { return GetBits( 7, 0 ); }
    inline u64 InSq() { return GetBits( 7, 7 ); }
    inline u64 EndSq() { return GetBits( 7, 14 ); }
    inline u64 SwiSq() { return GetBits( 7, 21 ); }
    inline u64 PieNum() { return GetBits( 2, 28 ); }
    inline u64 Pnum() { return GetBits( 2, 30 ); }
    inline u64 PPnum() { return GetBits( 4, 28 ); }
    void       InitPieceE( u64 Sq, u64 InSq, u64 EndSq, u64 SwiSq, u64 PlNum,
                           u64 PieNum );

    inline void Sq( u64 sq ) { SetBits( 7, sq, 0 ); }

    void CheckPiece();

   private:
    inline void InSq( u64 sq ) { SetBits( 7, sq, 7 ); }
    inline void EndSq( u64 sq ) { SetBits( 7, sq, 14 ); }
    inline void SwiSq( u64 sq ) { SetBits( 7, sq, 21 ); }
    inline void PieNum( u64 pieNum ) { SetBits( 2, pieNum, 28 ); }
    inline void Pnum( u64 pNum ) { SetBits( 2, pNum, 30 ); }
    inline void PPnum( u64 ppNum ) { SetBits( 4, ppNum, 28 ); }

   public:
    friend class DebugE;
};

// pp0-4 pp1-4 pp2-4 pp3-4 isSw1 Swpp2 to7 isSafe1 isEnd1
// 0      4     8    12     16    17    19   26      27     28
class SquareE : public BitsE
{
    const int M_Pi = G2::MAX_PIECES;

   public:
    inline u64 Pl( u64 pl ) { return ( GetBits( M_Pi, pl * M_Pi ) ); }
    inline u64 PP( u64 pl, u64 pi ) { return GetBit( ( pl * M_Pi + pi ) ); }
    inline u64 PP( u64 PPnum ) { return GetBit( PPnum ); }
    inline u64 IsSafe() { return GetBit( 26 ); }

    

    inline void PushPP( u64 pl, u64 pi ) { SetBit( pl * M_Pi + pi ); }
    inline void PushPP( u64 PPnum ) { SetBit( PPnum ); }
    inline void PopPP( u64 pl, u64 pi ) { UnSetBit( pl * M_Pi + pi ); }
    inline void PopPP( u64 PPnum ) { UnSetBit( PPnum ); }

    void CheckSquare();  // useless currently

    inline void SetSafe() { SetBit( 26 ); }
};

// from7  to7  PP4 isCap1  Cpl2 pieBits4  lsb->msb error
//   0     7    14  18     19    21 ---    25
class MoveE : public BitsE
{
   public:
    inline void From( u64 frm ) { SetBits( 7, frm, 0 ); }
    inline void To( u64 to ) { SetBits( 7, to, 7 ); }
    inline void PP( u64 pp ) { SetBits( 4, pp, 14 ); }
    inline void Pl( u64 pl ) { SetBits( 2, pl, 16 ); }
    inline void Pi( u64 pi ) { SetBits( 2, pi, 14 ); }
    inline void IsCap( u64 val ) { SetBits( 1, val, 18 ); }
    inline void CPl( u64 pl ) { SetBits( 2, pl, 19 ); }
    inline void PBits( u64 bits ) { SetBits( 4, bits, 21 ); }
    inline void CPiece( u64 piece ) { SetBit( 21 + piece ); }
    inline void Error( u64 code ) { SetBits( 4, code, 25 ); }

    inline u64 From() { return GetBits( 7, 0 ); }
    inline u64 To() { return GetBits( 7, 7 ); }
    inline u64 PP() { return GetBits( 4, 14 ); }
    inline u64 Pl() { return GetBits( 2, 16 ); }
    inline u64 Pi() { return GetBits( 2, 14 ); }
    inline u64 IsCap() { return GetBits( 1, 18 ); }
    inline u64 CPl() { return GetBits( 2, 19 ); }
    inline u64 PBits() { return GetBits( 4, 21 ); }
    inline u64 Error() { return GetBits( 4, 25 ); }

    void CheckMove();
    friend class DebugE;
};

// nm-sz:  player-2  pieces-4 error-4   DiceRoll-4
// start:    0         2           6     10

// nm-sz: Error-4  Roll-4 player -2 piece-4
// Start: 0          4     8          10
class ValidInput : public BitsE
{
   public:
    inline void Error( u64 code ) { SetBits( 4, code, 0 ); }
    inline void Roll( u64 roll ) { SetBits( 4, roll, 4 ); }
    inline void Pl( u64 pl ) { SetBits( 2, pl, 8 ); }
    inline void Pi( u64 pi ) { SetBit( 10 + pi ); }

    inline u64 Error() { return GetBits( 4, 0 ); }
    inline u64 Roll() {  return GetBits( 4, 4 ); }
    inline u64 Pl() { return GetBits( 2, 8 ); }
    inline u64 Pi() { return GetBits( 4, 10 ); }
    inline u64 HasPi( u64 which ) { return GetBit( 10 + which ); }
    inline void Clear(){PInt=(u64)0;}
    friend class DebugE;
};
