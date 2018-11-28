% set total time period:50. 
v=50;  
% generate the corresponding state of the world in each period
ra=rand(1,v);
rb=rand(1,v);
cb=rand(1,v);
ca=rand(1,v);

% generate the manager¡¯s behavior by the result of the state of world
for j=1: v
if rb(j)-ra(j)>=0.5
     t(j)=1;
else
     t(j)=0;
end
end
% calculate the integral of rb and ra conditional on information is not disclosed, denoting intb and inta.
for l= 1:20
syms p q
f1=int(p,q,0,p+l/20);
f2=int(p,q,0,1);
inta1=int(f1,p,0,1-l/20);
inta2=int(f2,p,1-l/20,1);
inta(l)=inta1+inta2;

end

for i= 1:199
    g(i)=i;
end

a=inta(10);
b=1-a;

% set initial endowment
x(1)=2;
y(1)=1; 


for i=1:v-1
% solve the competitive equilibrium
if t(i)==1
syms m n
eqn1 = rb(i)*y(i)/((ra(i)+rb(i))*m-ra(i)*x(i))==3*cb(i)*rb(i)/(3*ca(i)*ra(i)+(rb(i)*cb(i)-ca(i)*ra(i)*m));
eqn2 = n==3*cb(i)*m/(3*ca(i)+(cb(i)-ca(i))*m); 
[solm, soln]=solve([eqn1,eqn2] , [m,n]);
% update the next period endowment according to the solution 
x(i+1)=solm;
y(i+1)=soln;

else
% when the information is not disclosed, investor replace ra and rb by a and b.
syms m n
eqn1 = b*y(i)/((a+b)*m-a*x(i))==3*cb(i)/(3*ca(i)+(cb(i)-ca(i)*m));
eqn2 = n==3*cb(i)*m/(3*ca(i)+(cb(i)-ca(i))*m); 

[solm, soln]=solve([eqn1,eqn2] , [m,n]);
% update the next period endowment according to the solution 
x(i+1)=solm;
y(i+1)=soln;
k(i)=y(i)*ra(i)/x(i)*rb(i);
end

end
% plot the price trend
plot (g,k)
% plot the trace of the equilibrium
plot (x,y)
axis([0 3 0 3])
