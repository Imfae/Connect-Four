# Connect-Four

## Description

This is a command line version of Connect-Four. The program allows the game to be played between two human players or between a human and the computer.

The project is developed with TDD.

------

## Algorithm

The computer player uses a Minimax algorithm with Alpha-beta pruning. 

Given the sheer amount of moves needed before reaching a win or draw condition in Connect-Four, it's decided that a full call stack of minimax would be too deep for a computer to go through in a reasonable amount of time. Therefore, you'll find that the minimax search tree is cut off at a depth of 4, which means the computer searches 4 steps ahead before calculating the next move.

As for **Why 4?**: 4 is the sweet spot I find between an acceptable amount of time to wait while playing a game and a somewhat challenging opponent. (Otherwise, only a grand total of 7 moves would be needed to finish the game, *with optimized movements of course.*)

-------

## Notes

Through extensive testing, I found one 'quirk' of my minimax algorithm:

Suppose I have a board stacked in such way that when playing against a *perfect player*, the computer would lose in 2 steps if not played in a certain way, and loose in 4 steps if played in any way else, and if the minimax is set to explore ahead up to a depth of 4, the computer would 'give up' and 'let' the player win in 2 steps. 

Because in its 'mind' -- or, rather, algorithm as I designed it -- all losses within 4 steps are treated equally.

A possible solution to this pessimistic playing style is to penalize losses within fewer steps more heavily.

------

Play the game live here: [Replit](https://replit.com/@Conjurer/Connect-Four)