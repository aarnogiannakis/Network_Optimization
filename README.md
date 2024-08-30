# Network Optimization

**Project Overview**

The project involves optimizing the transportation of containers across a liner shipping network, where multiple routes may exist for moving containers between ports. The challenge is to efficiently utilize the network while respecting vessel capacities, especially for larger containers that cannot be split along different routes. This problem is modeled as a weighted multicommodity flow problem, which is known to be NP-hard.

The task includes managing transshipment, where containers may need to be unloaded and reloaded at intermediate ports. In the given scenario a small liner shipping network with nodes as ports and edges as legs sailed by vessels, each with specific costs and capacities. The objective is to optimize the flow of containers of varying sizes, measured in TEU (Twenty-foot Equivalent Units), through this network, ensuring efficient use of vessel capacity and minimizing costs.

More specifically: 

- The problem will be formulated using an edge formulation and will be solved an Integer Programming (IP) problem. The goal is to determine the optimal routes for different commodities, and you'll report the selected routes in a table.
- 
