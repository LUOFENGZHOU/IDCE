% set total time period:50. 
v=50;  
% generate the corresponding distribution
ra=rand(1,v);
rb=rand(1,v);
ca=rand(1,v);
cb=rand(1,v);
 
% set initial endowment
x(1)=2;
y(1)=1; 
 
for i= 1:v-1
    g(i)=i;
end
for i=1:v-1
% solve the competitive equilibrium
syms m n
eqn1 = rb(i)*y(i)/((ra(i)+rb(i))*m-ra(i)*x(i))==3*cb(i)*rb(i)/(3*ca(i)*ra(i)+(rb(i)*cb(i)-ca(i)*ra(i)*m));
eqn2 = n==3*cb(i)*m/(3*ca(i)+(cb(i)-ca(i))*m); 
 
[solm, soln]=solve([eqn1,eqn2] , [m,n]);
% update the next period endowment according to the solution 
x(i+1)=solm;
y(i+1)=soln;
 
% generate price vector
k(i)=y(i)*ra(i)/x(i)*rb(i);
end
 
% plot the price trend
plot (g,k)
 
% plot the trace of the equilibrium
plot (x,y)
axis([0 3 0 3])
