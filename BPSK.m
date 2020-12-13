function BPSK
%Input bits generation
N=10;%Input size
n=randi([0 1],1,N);
disp('Transmitted Data bits:')
disp(n)
for i=1:N
    if n(i)==0
        s(i)=-1;
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
title('BPSK:Data Bits')
%Carrier Signal generation
c = cos(2*pi*t);
subplot(4,1,2)
plot(t,c,'r');
xlabel('Time')
ylabel('Amplitude')
title('Carrier Signal')
%BPSK signal generation
x = signal.*c;
subplot(4,1,3)
plot(t,x,'k');
xlabel('Time')
ylabel('Amplitude')
title('Modulated Signal')
%no noise
y= x;
y1 = y.*c;
subplot(4,1,4)
plot(t,y1,'k');
xlabel('Time')
ylabel('Amplitude')
title('Recieved Signal')
int_op=[];
for i=1:S:length(y1)-S
    int_o= (1/S)*trapz(y1(i+1:i+S));
    int_op = [int_op int_o];
end
th =0;
recieved_data = (round(int_op,1)>=th);
disp('Recieved bits:')
disp(recieved_data)
%BER
ber = sum(n~=recieved_data)/N;
disp('Bit Error Rate:')
disp(ber)
end