%% 1b

N = 1;
M = 4000;
T = 2;
I = zeros(N, M);
for i = 1:600
    I(1,i) = 0;
end

for i = 800:1600
    I(1,i) = 1*10^(-9);
end

for i = 1800:2200
    I(1,i) = 2*10^(-9);
end

for i = 2400:3200
    I(1,i) = 3*10^(-9);
end

for i = 3400:4000
    I(1,i) = 4*10^(-9);
end

g_L = 30*10^(-9);
C = 300*10^(-12);
E_L = - 70 * 10^(-3);
V_T = 20 * 10^(-3);

V0 = zeros(N,M);
V1 = zeros(N);
    for i = 1:M
        if i>1
            V0(:,i) = V0(:,i-1);
        end
        t0 = T*(i-1)/M;
        h = T/(10*M);
        tn = t0 + T/M;
        while t0 <= tn
            vec = (1/C)*(-g_L*(V0(:,i)-E_L)+I(:,i));
            k1=h*vec; 
            t1=t0+h;
            vec2 = (1/C)*(-g_L*(V0(:,i)+k1-E_L)+I(:,i));
            k2=h*vec2;
            V1 = V0(:,i)+(k1+k2)/2;           
            t0 = t1;
            V0(:,i)=V1; 
            %fprintf('\n %4.3f  %4.3f ',V0,I); %values of x and y
        end
        ind = (V0  >= V_T);
        V0(ind) = E_L;
    end

plot(V0)