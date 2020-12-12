function FSK
%Input bits generation
N=10;%Input size
n=randi([0 1],1,N);
disp('Transmitted Data bits:')
disp(n)
for i=1:N
    if n(i)==0
        s(i)=0;
    else
        s(i)=1;
    end
end
S=1000;%samples per bit
m=1;
t=0:1/S:N;
for j=1:length(t)
    if t(j)<=m
        signal(j)=s(m);
    else
        signal(j)=s(m);
        m=m+1;
    end
end
figure;
subplot(4,1,1)
plot(t,signal,'m');
xlabel('Time')
ylabel('Amplitude')
title('Data Bits')
%Carrier Signal generation
c1 = sin(2*pi*t);
c2 = sin(2*pi*2*t);
subplot(4,1,2)
plot(t,c1,'r');
xlabel('Time')
ylabel('Amplitude')
title('Carrier Signal 1')
subplot(4,1,3)
plot(t,c2,'r');
xlabel('Time')
ylabel('Amplitude')
title('Carrier Signal 2')
%FSK signal generation
for j=1:length(t)
    if signal(j)==1
        x(j)=c1(j);
    else
        x(j)=c2(j);
    end
end
subplot(4,1,4)
plot(t,x,'k');
xlabel('Time')
ylabel('Amplitude')
title('FSK Modulated Signal')
%no noise
y= x;
y1 = y.*c1;
y2 = y.*c2;
int_op1=[];
int_op2=[];
for i=1:S:length(y1)-S
    int_o= (1/S)*trapz(y1(i+1:i+S));
    int_op1 = [int_op1 int_o];
    int_o1= (1/S)*trapz(y2(i+1:i+S));
    int_op2 = [int_op2 int_o1];
end
l = int_op1-int_op2;
recieved_data = (round(l,1)>=0);
disp('Recieved bits:')
disp(recieved_data)
%BER
ber = sum(n~=recieved_data)/N;
disp('Bit Error Rate:')
disp(ber)
end