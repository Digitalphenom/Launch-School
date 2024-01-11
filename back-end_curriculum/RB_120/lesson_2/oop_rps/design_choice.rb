# This version is better in the sense that it organizes functionality to its respective classes as opposed to a general purpose class. This is done by introducing the specialized classes Human and Computer from where specialized behavior stems from.

# A downside to this approach could be that if we introduce additional player, each new player now requires a new specialized class of its own. If we were to have a total of 10 different players, thats alot of code to write when we could have used a general purpose Player class to generalize common behavior. Although each player inherits from the Player class. Player is simply initializing the set_name method but its not being utilized in a general way, which means that the behavior would need to be re-defined for each additional new player.
