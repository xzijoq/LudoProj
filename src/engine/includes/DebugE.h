#pragma once


#include "CoreE.h"
//#include "EngineE.h"
#include <vector>
constexpr std::array LudoBoard{
    6, 7, 8, 23, 38, 53, 68, 83,                                     // 0-7
    99, 100, 101, 102, 103, 104, 119, 134, 133, 132, 131, 130, 129,  // 8-20
    143, 158, 173, 188, 203, 218, 217, 216, 201, 186, 171, 156,
    141,                                                        // 21-33
    125, 124, 123, 122, 121, 120, 105, 90, 91, 92, 93, 94, 95,  // 34-46
    81, 66, 51, 36, 21,                                         // 47-51
    // inSideSafe
    22, 37, 52, 67, 82,       // 52-56
    118, 117, 116, 115, 114,  // 57-61
    202, 187, 172, 157, 142,  // 62-66
    106, 107, 108, 109, 110,  // 67-71
    G2::START_POSI, G2::END_POSI };

constexpr std::array SpawnPoint{ 12, 192, 180, 0 };
class DebugE
{
   public:
    static void PrintPieceArray();
    static void zDebugPieceFunctions();
    static void zDebugMoveFunctions();
    static void zDebugSqFunctions();
    static void DisplayPMove( MoveE mv );
    static void DisplaySquares();
    static void DisplayBits( u64 num, int sp = 8,
                             bool displayDecimalVal = false );
    static void DisBits(u64 count,u64 num);

    static inline bool IsInRange( int value, int min, int max )
    {
        return ( value >= min && value < max );
    }
};