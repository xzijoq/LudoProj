#pragma once

#include <array>
#include <cstdint>
#define ARRAY_SIZE( a ) ( sizeof( a ) / sizeof( a[0] ) )

using u64 = std::uint_fast64_t;
namespace G2
{
struct IntV2
{
    int x;
    int y;
};

int constexpr MAX_ROW     = 15;
int constexpr MAX_COL     = 15;
int constexpr MAX_PLAYERS = 4;
int constexpr MAX_PIECES  = 4;
int constexpr START_POSI  = 72;
int constexpr END_POSI    = 73;
int constexpr OUTER_SZ    = 52;

u64 constexpr MAX_PP = G2::MAX_PIECES * G2::MAX_PLAYERS;



constexpr int BoardSize=74;


constexpr std::array SafeSq       = { 3,  11, 16, 24,         29,
                                37, 42, 50, START_POSI, END_POSI };
constexpr std::array StartSq      = {3,3,3,3};//{ 3, 16, 29, 2 };
constexpr std::array SwitchSq     = { 1, 14, 27, 40 };
constexpr std::array SwitchIntoSq = { 52, 57, 62, 67 };
constexpr std::array EndSq        = { 56, 61, 66, 71 };

}  // namespace G2
