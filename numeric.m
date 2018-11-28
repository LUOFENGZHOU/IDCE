%% Initialize
% define function expression
syms x;
syms y;
%f=(0.3-x)^3+(y-0.5)^3;
f=(y+1)/(x+1)
% decide initial point
x0=0.5;
y0=0.5;
% temp matrices
c0=zeros(100);
% report matrix
reportm=[2];
reportx=[x0];
reporty=[y0];
times=0;
ds=2;
%% Run
% calculate tangent plane, denoted as z
while(ds>0.02)
fx=diff(f,x);
fy=diff(f,y);
fx0=subs(fx,x,x0);
fx00=subs(fx0,y,y0);
fy0=subs(fy,x,x0);
fy00=subs(fy0,y,y0);
f0=subs(f,x,x0);
f00=subs(f0,y,y0);
z =f00 + fx00*(x-x0) + fy00*(y-y0);
%calculate nodeclaration area
nd=c0;
for i=1:100
    for j=1:100
        zk=subs(z,x,i/100);
        zkk=subs(zk,y,j/100);
        fk=subs(f,x,i/100);
        fkk=subs(fk,y,j/100);
        if zkk>fkk
            nd(i,j)=1;
        end
    end
end
s = regionprops(nd,'centroid');
q1=s.Centroid(1,1)/100;
q2=1-s.Centroid(1,2)/100;
ds=((q1-x0)^2+(q2-y0)^2)^(1/2);
t=reportm;
reportm=[t;ds];
t=reportx;
reportx=[t;q1];
t=reporty;
reporty=[t,q2];
x0=q1;
y0=q2;
times=times+1;
disp(times);
disp(ds);
 
end
%% show the result
% display the times
 
% display the contingency
 
% display the area of nd
[m,n] = size(nd);
[row1,col1] = ind2sub([m,n],find(nd==1));
[row2,col2] = ind2sub([m,n],find(nd==0));
figure, plot(col1,row1,'rs',col2,row2,'bo');
figure,hold on;
scatter(col1,row1,'filled'); scatter(col2,row2);
