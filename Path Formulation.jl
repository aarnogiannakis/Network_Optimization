using GLPK, JuMP
m = Model(GLPK.Optimizer)

cost = [1 10 23 16 34 60 92 40]
cap = [14 2 13 10 9 10 2 8 16]
d = [3 4 2]
w = [1 2 4]
routes = 1:8

#@variable(m, x[1:10], Bin) # number of routes
@variable(m, x[1:8]>=0, Int)
@objective(m, Min, sum(cost[i]*x[i]  for i in 1:8))

# capacity constraint
cap_AB = @constraint(m, w[1]*x[2] + w[1]*x[3] + w[2]*x[5] + w[2]*x[6] <= cap[1])
cap_AD = @constraint(m,  w[1]*x[1] + w[2]*x[4] <= cap[2])
cap_BC = @constraint(m, w[1]*x[3] + w[2]*x[6] + w[3]*x[7]   <=cap[3])
cap_BD = @constraint(m, w[1]*x[2] + w[2]*x[5] + w[3]*x[8] <= cap[4])
cap_CD = @constraint(m,  w[1]* x[3] + w[2]*x[6] + w[3]*x[7] <= cap[5])
# cap_DB = @constraint(m, ________ <= cap[6])
# cap_DA = @constraint(m, _________ <=cap[7])
cap_DE = @constraint(m,  w[3]*x[7] + w[3]*x[8] <= cap[8])
cap_EA = @constraint(m, w[2]*x[4] + w[2]*x[5] + w[2]*x[6] + w[3]*x[7] + w[3]*x[8]  <= cap[9])

# eligible flow
com_1=  @constraint(m, x[1] + x[2] + x[3] >= d[1])
com_2 = @constraint(m, x[4] + x[5]+ x[6] >= d[2])
com_3 = @constraint(m, x[7] + x[8] >= d[3])




print(m)
optimize!(m)
println("The optimal solution is: ", objective_value(m))
println("The selected routes are: ")
for i in 1:8
    println("$(x[i]) $(JuMP.value(x[i]))")
end
