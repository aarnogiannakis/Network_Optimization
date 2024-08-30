using JuMP, GLPK

# Define the model
model = Model(GLPK.Optimizer)

# Data
cost = [8, 1, 7, 2, 8, 2, 1, 1, 7]
cap = [14, 2, 13, 10, 9, 10, 2, 8, 16]
d = [-3, -4, -2]
w = [1, 2, 4]
num_routes = length(cost)
num_commodities = length(d)

# Variables: x[k, j] where k is the commodity and j is the route
@variable(model, x[1:num_commodities, 1:num_routes] >= 0, Int)

# Objective: Minimize the total cost
@objective(model, Min, sum(cost[j] * w[k] * x[k, j] for k in 1:num_commodities, j in 1:num_routes))

# Flow conservation constraints
for k in 1:num_commodities
    @constraint(model, x[k, 1] + x[k, 2] - x[k, 9] - x[k, 7] == (k == 1 ? -d[k] : 0))  # A
    @constraint(model, x[k, 3] + x[k, 4] - x[k, 1] - x[k, 6] == (k == 3 ? -d[k] : 0))  # B
    @constraint(model, x[k, 5] - x[k, 3] == 0)                                         # C
    @constraint(model, x[k, 8] + x[k, 7] + x[k, 6] - x[k, 5] - x[k, 4] - x[k, 2] == (k == 2 ? d[k] : d[1]))  # D
    @constraint(model, x[k, 9] - x[k, 8] == (k == 2 ? -d[k] : 0))                      # E
end

# Capacity constraints
for j in 1:num_routes
    @constraint(model, sum(w[k] * x[k, j] for k in 1:num_commodities) <= cap[j])
end

# Optimize the model
optimize!(model)

# Output the results
println("The optimal solution is: ", objective_value(model))
println("The selected routes are: ")
for k in 1:num_commodities
    for j in 1:num_routes
        println("x[$k,$j] = ", value(x[k, j]))
    end
end
