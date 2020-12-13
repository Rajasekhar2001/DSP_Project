function QPSK
%Input bits generation
N=10;
x = randi([0 1],1,N);
disp('Transmitted Data bits:')
disp(x)
for i=1:length(x)
    if x(i)==0
        p(i)=-1;
    else
        p(i)=1;
    end
end
%seperation of even and odd sequences
even_sequence = p(1:2:length(x));
odd_sequence = p(2:2:length(x));
i=1;
m = 2:2:length(x);
S=1000;
t = 0:1/S:length(x);
for j=1:length(t)
    if t(j)<=m(i)
        odd_ps(j) = odd_sequence(i);
    else
        odd_ps(j) = odd_sequence(i);
        i = i+1;
    end
end
k=1;
m1 = 2:2:length(x);
for j=1:length(t)
    if t(j)<=m1(k)
        even_ps(j) = even_sequence(k);
    else
        even_ps(j) = even_sequence(k);
        k = k+1;
    end
end
figure;
subplot(4,1,1)
plot(t,even_ps);
xlabel('Time')
ylabel('Amplitude')
title('QPSK :Even sequence Bits')
subplot(4,1,2)
plot(t,odd_ps);
xlabel('Time')
ylabel('Amplitude')
title('Odd sequence Bits')
%carrier waveforms
T =2;
c1 = (sqrt(2/T))*cos(2*pi*t);
c2 = (sqrt(2/T))*sin(2*pi*t);
subplot(4,1,3)
plot(t,c1,'r');
xlabel('Time')
ylabel('Amplitude')
title('Carrier Signal 1')
subplot(4,1,4)
plot(t,c2,'r');
xlabel('Time')
ylabel('Amplitude')
title('Carrier Signal 2')
% QPSK waveform generation
r1 = even_ps.*c1;
r2 = odd_ps.*c2;
qpsk_sig = r1+r2;
figure;
subplot(4,1,1)
plot(t,r1,'r');
xlabel('Time')
ylabel('Amplitude')
title('QPSK:Even sequence Modulated signal')
subplot(4,1,2)
plot(t,r2,'r');
xlabel('Time')
ylabel('Amplitude')
title('Odd sequence Modulated signal')
subplot(4,1,3)
plot(t,qpsk_sig);
xlabel('Time')
ylabel('Amplitude')
title('QPSK Modulated signal')
%no noise
y= qpsk_sig;
subplot(4,1,4)
plot(t,y,'k');
xlabel('Time')
ylabel('Amplitude')
title('Recieved Signal')
y1 = y.*c1;
y2 = y.*c2;
int_op1=[];
int_op2=[];
for i=1:(2*S):length(y1)-S
    int_o= (1/S)*trapz(y1(i+1:i+S));
    int_op1 = [int_op1 int_o];
end
for i=1:(2*S):length(y2)-S
    int_o= (1/S)*trapz(y2(i+1:i+S));
    int_op2 = [int_op2 int_o];
end
th =0;
bit1 = (round(int_op1,1)>=th);
bit2 = (round(int_op2,1)>=th);
recieved_data = zeros(1,2*(length(bit1)));
k=1;
m=1;
for i=1:(2*length(bit1))
    if mod(i,2)==1
        recieved_data(i)=bit1(k);
        k=k+1;
    else
        recieved_data(i)=bit2(m);
        m=m+1;
    end
end
disp('Recieved bits:')
disp(recieved_data)
%BER
ber = sum(x~=recieved_data)/N;
disp('Bit Error Rate:')
disp(ber)
end