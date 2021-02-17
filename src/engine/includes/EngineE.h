#pragma once
#include <vector>

#include "CoreE.h"
int   man();
MoveE OnPieceClicked( u64 pl, u64 pi );

ValidInput        GetValidInputs(int roll);
std::vector<MoveE> OnPC( const u64 pl, const u64 pi );
int EndTurn();
using std::array;
using std::vector;

extern array<SquareE, G2::BoardSize>            Sq;
extern array<PieceE, G2::MAX_PLAYERS * G2::MAX_PIECES> Pp;

extern vector<MoveE> MoveStack;
extern void          PushMove( MoveE mv );
extern MoveE         PopMove();
extern void          InitBoardE();

