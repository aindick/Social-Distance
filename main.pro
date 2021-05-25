% [EX, EY] are at least 6 feet away from every element in the location.
%L stands for location and p stands for the path.
% [EX, EY], End, and L are within range of [TX, TY].

%Rpath is the path reversed.
%The RPath is the path reversed since we add [VX,VY] as the head.
% The starting point for P is [EX, EY].
	
solve([EX,EY], End, [TX, TY], L, P) :- 
	safe(L, [EX, EY]), 
    legalStartEnd([EX, EY], End, [TX, TY]), 
    legalLocation(L, [TX, TY]),
    travel([EX, EY], End, [TX, TY], L, RPath, [[EX,EY]]), 
    reverse(RPath, P).
    
	
    






%Base case
%Our movement should be both legal and safe.
%V stands for the coordinates that have been visited. 
travel(_, End, [TX, TY], L, [[LX,LY],[VX,VY]|V], [[VX,VY]|V]) :- 
    LY is End, LY is VY + 1, LX is VX,
    legal([TX,TY], [LX,LY], [[VX,VY]|V]),
    safe(L, [LX,LY]).
    
%Recursive case
travel([EX, EY], End, [TX, TY], L, P, V):- 
	legal([TX, TY], [LX, LY], V), 
	safe(L, [LX, LY]), 
    travel([EX, EY], End, [TX, TY], L, P, [[LX,LY]|V]).










%1 feet apart and not negative integers. Has to be within the grid also.
%Legal for moving upward 1 space.
legal([TX,TY],[LX,LY],[[VX,VY]|V]) :-
    LX is VX, LY is VY + 1,
    LX < TX, LY < TY,
    LX >= 0, LY >= 0,
    integer(LX), integer(LY),
    \+member([LX,LY],[[VX,VY]|V]).




%Legal for moving right 1 space.
legal([TX,TY],[LX,LY],[[VX,VY]|V]) :-
    LX is VX + 1, LY is VY,
    LX < TX, LY < TY,
    LX >= 0, LY >= 0,
    integer(LX), integer(LY),
    \+member([LX,LY],[[VX,VY]|V]).




%Legal for moving left 1 space.
legal([TX,TY],[LX,LY],[[VX,VY]|V]) :-
    LX is VX - 1, LY is VY,
    LX < TX, LY < TY,
    LX >= 0, LY >= 0,
    integer(LX), integer(LY),
    \+member([LX,LY],[[VX,VY]|V]).


%Next movement/travel is 6 feet away from every element in L.
%Base case 
safe([], _).

%Recursive case
safe([[MX,MY]|L], [LX, LY]) :- sqrt((LX-MX)^2 + (LY-MY)^2) >=6, safe(L, [LX,LY]).
     








%[EX, EY] and End are within range of [TX, TY] and are not negative integers.
legalStartEnd([EX, EY], End, [TX, TY]) :- 
	EX >= 0, EX < TX, integer(EX), 
    EY >= 0, EY < TY, integer(TY),
    End >= 0, End < TY, integer(End).


%L are within range of [TX, TY] and are not negative integers.
%Base case
legalLocation([], _).

%Recursive case
legalLocation([[MX,MY]|L], [TX, TY]) :- 
    MX >= 0, MX < TX, integer(MX),
    MY >= 0, MY < TY, integer(MY),
legalLocation(L, [TX, TY]).
