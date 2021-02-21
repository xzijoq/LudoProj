extends Node



class BitsE:


	var                  PInt:int =0 ;
	var pows=[0b0,     0b1,      0b11,      0b111,     0b1111,  
				0b11111, 0b111111, 0b1111111, 0b11111111]


	func GetBit(bit:int)->int:
		return ( ( PInt >> bit ) & 1 )

	func SetBit(bit:int)->void:
		PInt |= 1 << bit
	
	func UnSetBit(bit:int)->void:
		PInt &= ~( 1 << bit )

	func SetBits( count:int ,bits:int, posi:int)	->void:
		if bits>pows[count]:
			bits=pows[count]
		PInt &= ~( pows[count] << posi );
		PInt |= bits << posi;

		pass
	
	func GetBits(count:int, posi:int )->int:
		return ((PInt>>posi)&pows[count])

	func ToInt()->int:
		return PInt


#  PPnum(4 (0-16)) //Switch Into 7// EndSq 7// InSq 7// Square 7
#  32-30       28            21        14         7       0
class PieceE extends BitsE:

	static func GetPPnum(pl:int,pi:int)->int:
		return ( pl * Gl.MAX_PIECES + pi );


	func Sq()->int:
		return GetBits( 7, 0 )
	func InSq()->int:
		return GetBits( 7, 7 )
	func EndSq()->int:
		return GetBits( 7, 14 )
	func SwiSq()->int:
		return GetBits( 7, 21 )
	func PieNum()->int:
		return GetBits( 2, 28 )
	func Pnum()->int:
		return GetBits( 2, 30 )
	func PPnum()->int:
		return GetBits( 4, 28 )
	

	#todo	
	func InitPieceE(Sq:int, InSq:int, EndSq:int, SwiSq:int, PlNum:int, PieNum:int)->void:
		SetSq( Sq );
		SetInSq( InSq );
		SetEndSq( EndSq );
		SetSwiSq( SwiSq );
		SetPNum( PlNum );
		SetPieNum( PieNum );
	
		pass

	
 
	func SetSq( sq:int)->void:
		SetBits( 7, sq, 0 )

	func CheckPieces():
		pass

		
	func SetInSq(sq:int):
		SetBits( 7, sq, 7 )


	func SetEndSq(sq:int):
		SetBits( 7, sq, 14 )
	
	func SetSwiSq(sq:int):  
		SetBits( 7, sq, 21 ); 
	func SetPieNum(pieNum:int):
		SetBits( 2, pieNum, 28 )
	func SetPNum(pNum:int):
		SetBits( 2, pNum, 30 );

 
	func SetPPnum(ppNum:int):
		SetBits( 4, ppNum, 28 )


# pp0-4 pp1-4 pp2-4 pp3-4 isSw1 Swpp2 to7 isSafe1 isEnd1
# 0      4     8    12     16    17    19   26      27     28

class SquareE extends BitsE:
	const M_Pi = Gl.MAX_PIECES

	func Pl(pl:int):
		return ( GetBits( M_Pi, pl * M_Pi ))

	func PP2(pl:int, pi:int)->int:
		return GetBit( ( pl * M_Pi + pi ))

	func PP(PPnum:int)->int:
		return GetBit( PPnum )

	func IsSafe()->int:
		return GetBit( 26 )


	
	func PushPP2(pl:int, pi:int ):
		SetBit( pl * M_Pi + pi );

	func PushPP(PPnum:int):
		SetBit( PPnum )

	func PopPP2( pl: int, pi:int):
		UnSetBit( pl * M_Pi + pi )
	
	func PopPP(PPnum:int):
		UnSetBit( PPnum )
 

	func SetSafe():
		SetBit(26)


# from7  to7  PP4 isCap1  Cpl2 pieBits4  lsb->msb error
#   0     7    14  18     19    21 ---    25
class MoveE extends BitsE:

	func SetFrom( frm ): 
		SetBits (7,frm,0)
	func SetTo(  to ):  
		SetBits( 7, to, 7 ); 
	func SetPP( pp ):  
		SetBits( 4, pp, 14 ); 
	func SetPl( pl ):  
		SetBits( 2, pl, 16 ); 
	func SetPi( pi ):  
		SetBits( 2, pi, 14 ); 
	func SetIsCap(  val ) :
		 SetBits( 1, val, 18 ); 
	func SetCPl( pl ):
		SetBits( 2, pl, 19 ); 
	func SetPBits( bits ): 
		SetBits( 4, bits, 21 ); 
	func SetCPiece(  piece ): 
		SetBit( 21 + piece ); 
	func SetError(  code ) :
		SetBits( 4, code, 25 ); 
	
	func From() ->int: 	
		return GetBits( 7, 0 ); 	
	func To()   ->int: 	
		return GetBits( 7, 7 ); 	
	func PP()   ->int: 	
		return GetBits( 4, 14 ); 	
	func Pl()   ->int: 	
		return GetBits( 2, 16 ); 	
	func Pi()   ->int: 	
		return GetBits( 2, 14 ); 	
	func IsCap()->int: 	
		return GetBits( 1, 18 ); 	
	func CPl()  ->int: 	
		return GetBits( 2, 19 ); 	
	func PBits()->int: 	
		return GetBits( 4, 21 ); 	
	func Error()->int: 	
		return GetBits( 4, 25 ); 




# nm-sz: Error-4  Roll-4 player -2 piece-4
# Start: 0          4     8          10
class ValidInput extends BitsE:


	func SetError(  code ):
		 SetBits( 4, code, 0 )
	func SetRoll(  roll ):  
		SetBits( 4, roll, 4 ); 
	func SetPl(  pl ):
		  SetBits( 2, pl, 8 ); 
	func SetPi(  pi ):
		  SetBit( 10 + pi ); 


	func Error() :
		 return GetBits( 4, 0 ); 
	func Roll()  :
		 return GetBits( 4, 4 ); 
	func Pl() :
		 return GetBits( 2, 8 ); 
	func Pi() :
		 return GetBits( 4, 10 ); 
	func HasPi( which ) :
		return GetBit( 10 + which ); 

	func Clear():
		PInt=0;


func DisplayBits(num:int, sp:int, val:bool):
	for i in range(63,0,-1):

		if ( val ):
			print(num&1<< i)
		else: 
			if num & 1 << i:
				  print(1)
			else :
				 print(0)
	 
		if ( ( i ) % sp == 0 ):
			  print("--")
		if ( ( i ) % 4 == 0 && sp == 8 ):
			  print("-")
	



func _ready():
	Sq.resize(Gl.BoardSize)
	Pp.resize(Gl.MAX_PLAYERS*Gl.MAX_PIECES)
	#print(test)

	pass




var Sq=[]
var Pp=[]

var        TurnNumber :int = 0;
var        RollG      :int = 1;
var OutVIn=ValidInput.new() ;

var Moves=[]
var ValidInp=[]
var MoveList=[]

enum TurnS{
	Player0S,
	Player1S,
	Player2S,
	Player3S
}
var CurrentTurn=TurnS;

#func PushMove(  mv:MoveE ):
#	 MoveStack.push_back( mv ); 

func StartTurn(  ):

	#// if ( CurrentState != InitTurnS ) { return -CurrentState; }
	TurnNumber+=1;
  
	#// std::cout << "current Turn player: " << CurrentTurn << "\n";
	MoveList.clear();


	return 0;


func GetValidInputs( roll:int )->int :

	RollG = roll;

	OutVIn.Clear();
	OutVIn.SetRoll( RollG );
	OutVIn.SetPl( CurrentTurn );	
	#for ( auto piece = 0; piece < G2::MAX_PIECES; piece++ )
	for piece in range(0,Gl.MAX_PIECES):   
		var pp = PieceE.GetPPnum( CurrentTurn, piece );	
		#// if ( Pp[pp].Sq() != G2::START_POSI &&
		if ( Pp[pp].Sq() + RollG < Pp[pp].EndSq() ) :
			 OutVIn.SetPi( piece ); 
			 pass
		if ( RollG == 6 || RollG == 1 ) && Pp[pp].Sq() == Gl.START_POSI :
			OutVIn.SetPi( piece ); 


	return OutVIn.PInt;

#// currently OnPc need more for powers
#//add move powers here

func OnPC( pl:int,  pi:int ):
	MoveList.clear();	
	#  	 // init data-------------------------------------
	#assert( pl < G2::MAX_PLAYERS && pi < G2::MAX_PIECES );
	var Roll = RollG;
	var Mv=MoveE.new()
	
	var  i    = PieceE.GetPPnum( pl, pi );
	var  From = Pp[i].Sq();
	var       To   = 0;	
	#//DebugE::DisplayValidInput(OutVIn);
	#
	#// Verify ValidInput
	if ( ( pl != OutVIn.Pl() ) && ( !OutVIn.HasPi( pi ) ) ):

		print("\nInvalidIputClientHacked\n")
		#//return MoveList;

	#// Start Sq-----------------------------
	if ( Pp[i].Sq() == Gl.START_POSI ):
		To = Gl.StartSq[pl]; 
	#// else
	elif ( From < Pp[i].InSq() ):
	
		To = ( From + Roll ) % Gl.OUTER_SZ;
	
	else:
	
		To = ( From + Roll );
		
	#// Switch into safe zone---------------------


	if ( From < Gl.OUTER_SZ ):
	# // if in the path from->to if find insq swithc into it
		var tTo:int = To;		
		var z=From 
		var y=0 	
		#for ( int z = From, y = 0; z != tTo; z = ( z + 1 ) % Gl.OUTER_SZ )	
		while z!=tTo:
			if ( Pp[i].SwiSq() == z ):
				#// calculate the moves left
				var movesLeft:int = Roll - y - 1;
				To            = Pp[i].InSq() + movesLeft;
			
			z = ( z + 1 ) % Gl.OUTER_SZ
			y+=1
		
		
	#// END----------------------------------
	if ( To > Pp[i].EndSq() ):
		  To = Gl.END_POSI; 
	#// capture------------------------------------------
	if ( !Sq[To].IsSafe() ):


		#for ( int player = 0; player < G2::MAX_PLAYERS; player++ ):
		for player in range(0,Gl.MAX_PLAYERS):
			if ( Sq[To].Pl( player ) != 0 && player != pl ):
							var cMv=MoveE.new();
							cMv.SetIsCap( 1 );
							Mv.SetIsCap( 1 );
							Mv.SetCPl( player );
							Mv.SetPBits( Sq[To].Pl( player ) );
							#// send all pieces home
							#for ( int piece = 0; piece < G2::MAX_PIECES; piece++ )

							for piece in range (0,Gl.MAX_PIECES):
							
								if ( Sq[To].PP2( player, piece ) != 0 ):

									
									var j:int = PieceE.GetPPnum( player, piece );	
									Pp[j].SetSq( Gl.START_POSI );
									Sq[To].PopPP2( player, piece );
									Sq[Gl.START_POSI].PushPP2( player, piece );	
									cMv.SetPl( player );
									cMv.SetPi( piece );
									cMv.SetFrom( To );
									cMv.SetTo( Gl.START_POSI );
									print("PlPi: ",cMv.Pl()," ",cMv.Pi()," to: ",cMv.To())
									
									MoveList.append(cMv.PInt  );

									#wow.resize(wow.size()+1)
									#wow[yada]=cMv


					
				
				
				
		
	#// no cap case
	#// adjust player	

	Mv.SetFrom( From );
	Mv.SetTo( To );
	Mv.SetPl( pl );
	Mv.SetPi( pi );


	Pp[i].SetSq( To );
	Sq[From].PopPP( i );
	Sq[To].PushPP( i );


	#//  DebugE::DisplaySquares();
	#// DebugE::DisplayPMove( Mv );
	MoveList.push_back( Mv.PInt );
	#// no cap as	
	#// Mv.CheckMove();
	#// TODO: push move to stack
	#//EndTurn();

	return MoveList;



func EndTurnM():
	#//Calling this will clear MoveList via a call to initmove
	
	#// if ( CurrentState != MakeMoveS ) { return -CurrentState; }
	var NextPlayer:int = CurrentTurn;
   # // endturn
	#// push MoveTOstack for roll back
	if ( RollG != 6 ):
	  
	   NextPlayer = ( NextPlayer + 1 ) % 4; 
	   #//if (NextPlayer==0){NextPlayer=3;}
	   #//else{NextPlayer=0;}
	   
	   
	
	#//NextPlayer=0;
	#// cout << "turn Ended\n";
	CurrentTurn=NextPlayer;
	StartTurn( );
	return 0;


func man():


	CurrentTurn=0;
	#//ValidInput in;

	InitBoardE();
	return 0;

func InitBoardE():
	Sq.resize(Gl.BoardSize)
	Pp.resize(Gl.MAX_PLAYERS*Gl.MAX_PIECES)

	for i in range(0,Pp.size()):
		var temp=PieceE.new()
		Pp[i]=temp

	for i in range(0,Sq.size()):
		var temp=SquareE.new()
		Sq[i]=temp
	#print(Pp[1].Pnum())
	for i in range(0,Gl.MAX_PLAYERS):
		for j in range(0,Gl.MAX_PIECES):

			Pp[i * Gl.MAX_PIECES + j].InitPieceE(
				Gl.START_POSI, Gl.SwitchIntoSq[i], Gl.EndSq[i],
				Gl.SwitchSq[i], i, j );
			Sq[Gl.START_POSI].PushPP2( i, j );
		
	
	for  i in Gl.SafeSq :
			Sq[i].SetSafe(); 





####GAMEW ENGINE>CPP
func StartGame():
	man();

func GetValidInp()->ValidInput:

	ValidInp.clear();
	var vi=ValidInput.new();
	var cr = GetValidInputs( 1 );
	vi.PInt=cr
	#// DebugE::DisplayValidInput(vi);
	ValidInp.append( vi.Error() );
	ValidInp.append( vi.Roll() );
	ValidInp.append( vi.Pl() );
	for i in range (0,4):
			ValidInp.append( vi.HasPi( i ) ); 
	return ValidInp;


func PGclicked( pl:int, go:int ):

	#vector<MoveE> mv;
	var mv=[]
	mv = OnPC( pl, go );


	
   # // move.clear();

	Moves.clear();
	#for ( auto i = 0; i < mv.size(); i++ )
	for i in range (0,mv.size()):
		var mvP=MoveE.new()
		mvP.PInt=mv[i]
		var move=[];
		move.clear();
		move.resize( 3 );
		move[0] = mvP.Pl();
		move[1] = mvP.Pi();
		move[2] = mvP.To();
		Moves.append( move );

	
   # //for ( auto i : mv ) { DebugE::DisplayPMove( i );}
   # //std::cout<<mv.size(); }
   #// EndTurn();
	return Moves;


func EndTurnE():
	
	EndTurnM();


func StartTurnE(_player:int):
	
	StartTurn();



func GetSquare(sq:int):


	var pg=[];

	#for (auto pl =0;pl<G2::MAX_PLAYERS;pl++){
	for pl in range(0,Gl.MAX_PLAYERS):	       
		for pie in range(0,Gl.MAX_PIECES):
			if (Sq[sq].PP2(pl,pie)!=0):
				   var pp=[];
				   pp.clear();
				   pp.append(pl);
				   pp.append(pie);
				   pg.append(pp);
			
		
	

	return pg;

func GetMoves():	
	return Moves;
 



