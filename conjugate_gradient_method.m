function [x]= conjugate_gradient_method(A,b,x)
    r0=b-A*x;% A is a square matrix of nxn and x is a vector of nx1
             % b is also a vector of nx1 order
             % equation is of form AX=B
    d=r0;
    for i= 1:length(b)
        alpha = (r0'*r0)/(d'*A*d);fprintf('alpha = %f\n\n',alpha);
        x = x + alpha * d;fprintf('x = %f\n',x);fprintf('\n');
        r1 = r0 - alpha * A * d;fprintf('r = %f\n',r1);fprintf('\n');
        if sqrt(r1'*r1)< 1e-10
            break;
        end
        beta = (r1'*r1)/(r0'*r0);fprintf('beta = %f\n',beta);fprintf('\n');
        d = r1 + beta * d;fprintf('d = %f\n',d);fprintf('\n');
        r0 = r1;
        fprintf('----------------------------------\n\n');
    end
end
