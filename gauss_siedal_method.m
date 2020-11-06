n=input('Enter number of simultaneous equation : ');
a=input('Enter the coefficient matrix [a] : ');
b=input('Enter the constant column matrix {b} : ');
x=input('Initialze all values {x} : ');
for c=1:100
for i = 1:n
    sum=0;
    for k = 1:n
        if k~=i
            sum=sum+a(i,k)*x(k);
        end
    end
    x(i)=(b(i)-sum)/a(i,i); %suppose i=1 then x(1) gives value of 1st row
end
end
disp(x) %disp display each value in new line
    