function  tappered_bar(At,Ab,l,fb,E,n,filename)
    y0=At;
    %filename=tostirng(rand);At=area at fixed end Ab=area at free end
    K=zeros(n);k=linspace(0,0,n);f=linspace(0,0,n)';f(n)=fb;%fb=axial force at free end and n=no. of element
    op=fopen(filename,'wt');
    fprintf(op,'=======================================================================\n');fprintf('=======================================================================\n');
    fprintf(op,'\t\t\tTappered bar solution by FEM\n'); fprintf('\t\t\t\t\tTappered bar solution by FEM\n');
    fprintf(op,'-----------------------------------------------------------------------\n');fprintf('-----------------------------------------------------------------------\n');
    fprintf(op,'Maximum area = %f\t\t\t',At); fprintf(op,'Minimum area = %f\n',Ab);fprintf('Maximum area = %f\t\t\t\t',At); fprintf('Minimum area = %f\n',Ab);
    fprintf(op,'Force at minimum area = %f\t',fb); fprintf(op,'Lenght = %f\n',l);fprintf('Force at minimum area = %f\t',fb); fprintf('Lenght = %f\n',l);
    fprintf(op,'Modulus of elasticity = %f\t',E); fprintf(op,'No. of element = %f\n',n); fprintf('Modulus of elasticity = %f\t',E); fprintf('No. of element = %f\n',n);
    fprintf(op,'-----------------------------------------------------------------------\n');fprintf('-----------------------------------------------------------------------\n');
    for i = 1:n
        yi = (Ab-At)*i/n+At;
        Ai= (y0 +yi)/2;
        k(i)=n*E*Ai/l; 
        y0=yi;
        fprintf(op,'A%d = %f\t',i,Ai);fprintf('A%d = %f\t',i,Ai);
        fprintf(op,'k%d = %f\n',i,k(i));fprintf('k%d = %f\n',i,k(i));
    end
    fprintf(op,'-----------------------------------------------------------------------\n'); fprintf('-----------------------------------------------------------------------\n');
    for i=1:n
        for j=1:n
            if abs(i-j)==1
                if i>j 
                    K(i,j)=-k(i);
                elseif j>i
                        K(i,j)=-k(j);
                end
            elseif i==n && j==n
                    K(i,j)=k(i);
            elseif i~=n && j~=n && i==j 
                    K(i,j)=k(i)+k(i+1);
            end
        end    
    end
    u =  inv(K)*f;
    disp('K = ');fprintf(op,'K = \n');
    disp(K);
    for i=1:n
        for j=1:n
            fprintf(op,'%f\t',K(i,j));
        end
        fprintf(op,'\n');
    end
    fprintf(op,'-----------------------------------------------------------------------\n');fprintf('-----------------------------------------------------------------------\n');
    for i=1:n
        fprintf(op,'u%d = %f\n',i,u(i));fprintf('u%d = %f\n',i,u(i));
        %u_approx=ui;
    end
    fprintf(op,'=======================================================================\n');fprintf('=======================================================================\n');
    fprintf(op,'\t\t\tExact solution of Tappered bar\n');fprintf('\t\t\t\t\tExact solution of Tappered bar\n');
    fprintf(op,'-----------------------------------------------------------------------\n');fprintf('-----------------------------------------------------------------------\n');
    syms x;
    Area_at_x = (Ab-At)*x/l+At;
    del= (fb/E)*int(1/Area_at_x,x,0,l);
    fprintf(op,'\t\t\t\tdel = %f\n',del);fprintf('\t\t\t\t\t\t\tdel = %f\n',del);
    fprintf(op,'=======================================================================\n');fprintf('=======================================================================\n');
    plot(n,u(n),'r*',n,del,'gx');
    xlabel('no. of Elements for FEM solution');ylabel('Displacement');title('Comapring FEM and Exact solution');
    legend('FEM solution','Exact solution');
    fclose(op);
end