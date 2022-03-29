# EvoSim

A simple evolution simulator I made back in 2019. Creatures move across the world in search of food and reproduce.
Initially, they blindly crawl around, but through random mutations and natural selection, they learn to become more efficient over time.

# Starting Out

Move the camera around with the **WASD** or arrow keys and zoom in and out with the mouse's scroll wheel.

At the bottom of the world is an initial starting creature which moves around aimlessly and collects the green food pellets.
When it gains enough energy from eating, it will reproduce and a daughter creature will appear next to it.
This will repeat until the world is fully populated. (Though sometimes the starter may get unlucky and die before than can happen.)

The simulation can be sped up or slowed down by pressing **Z** or **X** respectively.

# Genes

Each creature has a set of genetic information that determines its behavior. This information is passed onto offspring and may mutate.
The main attribites of behavior are based on a network of different types of genes. A gene links to one or two other genes that get activated after itself.
Some genes perform an action such as movement, while others read the environment and decide whtch other gene to activate based on the result.
When combined together, this allows more robust and complex behavior to emerge.

There is also a special gene that detemines a creature's diet. The starting creature is a herbivore that can only eat the green food that appears throughout the world.
However, they may opt to become more omnivorous, gaining the ability to eat herbivores but getting less energy from the other food.
Moving up the food chain makes a creature able to eat anything less carnivorous than it.
This is indicated by the creature's body color, with blue being a full herbivore and red being a full carnivore.
