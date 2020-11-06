function Simplex_method(a,b)
    aa=a;
    size_of_matrix=size(aa);
    n=size_of_matrix(1,1);
    dv=size_of_matrix(1,2);
   
    disp('Coefficients of decision variables in matrix form, a :');disp(a);
    disp('RHS constant in matrix form, b :');disp(b);
    fprintf('The number of decision variables are: %d\n',dv);
    fprintf('The number of Equation are: %d\n',n);
    
    format short;
    % dv is number of decision variables.
    %disp(a);         %a is matrix of coefficient of decision variables
    s=zeros(n,n-1);  %s is slack variable and n is number of constraints/std equations including obj. Function
    z=zeros(n,1); slack=zeros(n-1,1);x=zeros(dv,1); ratio=zeros(n,1);ratio_temp=zeros(n,1);
    variables=zeros(1,dv+n-1); BV=zeros(n-1,1); %BV=Basic variables
    %BV(1,1) to BV(dv,1) represents decision variables
    %BV(dv+1,1) to BV(dv+n-1,1) represents slack variables
    %augmented_matrix = zeros(n,dv+n); %represents augmented matrix of a,s and b
    pivot_column_element = zeros(n,1);
    
    for i=1:dv
        x(i,1)=0;
    end
    
    for i = 1:n-1
        slack(i,1) = b(i,1);
    end
    
    %disp('Initial x');disp(x);
    %disp('Initial slack');disp(slack);
    
    z(n,1)=1;
    
    for i=1:n-1
        for j=1:n-1
            if i==j
                s(i,j)=1;
            end
        end
    end
    
    %disp(s);
    
    %Representing decisions variables and slack variables with numbers
    %with decison variables coming first then slack variables
    for i=1:(dv+n)
        variables(1,i) = i;
    end
    
    %Representing basic variables with numbers
    for i=(dv+1):(dv+n)
        format short;
        BV(i-dv,1) = i;
        %BV(i-dv,1)=digits(4);
    end
    
    %disp('Variables/Columns of Simplex Table'); disp(variables);
    %disp('Basic variables (BV)'); disp(BV);
    
    augmented_matrix = [aa s b];
    %disp('Simplex Table Augmented');disp(augmented_matrix);
    %disp('(3,8) element of augmented'); disp(augmented_matrix(3,8));
    
    %Loop will start from here and will run until all the coefficient in
    %the objective function are positive.
    
    k=0;
    while true
        k=k+1;
        
    %Finding maximum negative value and pivot_column or Entering variable
    min_val=augmented_matrix(n,1);
    pivot_column=1;
    for j=2:(dv+n-1)
        if augmented_matrix(n,j)<min_val
           min_val = augmented_matrix(n,j);
           pivot_column=j;
        end
    end
    
    %Check for optimality
    if min_val >=0
        
        fprintf('Iteration #%d \n',k); %disp(augmented_matrix);
    
        fprintf('-------------------------------------------------------------------------------------\n');
    
        fprintf('\t  BV');
        fprintf('\t\t  Z'); 
    
        %to print the heading of decision variables like x1,x2...
        for i=1:dv
            fprintf('\t     x%d(%d)',i,i);
        end
    
        %to print the heading of slack variables like s1,s2...
        fprintf('');
        for i=1:(n-1)
            fprintf('   s%d(%d)  ',i,i+dv);
        end
    
       %print heading for RHS or Solution
       fprintf('  RHS(%d)',dv+n);
    
       %fprintf('\tratio');
    
       %print line 
       fprintf('\n-------------------------------------------------------------------------------------');
    
       fprintf('\n');
        
       disp([BV z augmented_matrix]);
        
       fprintf('Optimal solution reached.\n');
        %printing values of decision variables
       for i=1:dv
           fprintf('x%d = %f\n',i,x(i,1));
       end
    
       %printing values of slack variables
       for i=(dv+1):(dv+n-1)
           fprintf('S%d = %f\n',i-dv,slack(i-dv,1));
       end
     
       % to print the value of Z
       fprintf('Optimum Value of Z = %f\n',augmented_matrix(n,dv+n));
     
       %fprintf('Optimal solution reached.\n');
       %Now the program has to be stopped...........ENDED.....Terminated
       break;
    end
    
    %disp('Pivot_column'); disp(pivot_column);
    %fprintf('\nThe Most negative number in bottom row = %f',min_val);
    %fprintf('\nPivot Column = %d',pivot_column);
    %fprintf('\n(Since %f is the most negative number in bottom row & lies in column %d)\n\n',min_val,pivot_column);
    %disp('Min_val');disp(min_val);
    
    %Finding miminum positive ratio and Pivot_row or leaving variable
    for i=1:n-1
        ratio(i,1) = augmented_matrix(i,dv+n)/augmented_matrix(i,pivot_column);
        %augmented_matrix(i,dv+n) is b(i,1)
    end
    
    %disp('ratio'); disp(ratio);
    
    fprintf('***************************************************************************************************\n');
    fprintf('\t\t\t\t\t\t\t\tIteration #%d \n',k); %disp(augmented_matrix);
    
    fprintf('---------------------------------------------------------------------------------------------------\n');
    
    fprintf('\t  BV');
    fprintf('\t\t  Z'); 
    
    %to print the heading of decision variables like x1,x2...
    for i=1:dv
        fprintf('\t     x%d(%d)',i,i);
    end
    
    %to print the heading of slack variables like s1,s2...
    fprintf('');
    for i=1:(n-1)
        fprintf('   s%d(%d)  ',i,i+dv);
    end
    
    %print heading for RHS or Solution
    fprintf('  RHS(%d)',dv+n);
    
    fprintf('\tratio');
    
    %print line 
    fprintf('\n---------------------------------------------------------------------------------------------------');
    
    fprintf('\n');
    
    
    
    %diplay the augmented matrix along with BV, Z and ratio
    disp([BV z augmented_matrix ratio]);
    
    %printing values of decision variables
     for i=1:dv
         fprintf('x%d = %f\n',i,x(i,1));
     end
    
     %printing values of slack variables
     for i=(dv+1):(dv+n-1)
         fprintf('S%d = %f\n',i-dv,slack(i-dv,1));
     end
     
     % to print the value of Z
     fprintf('Value of Z = %f\n',augmented_matrix(n,dv+n));
    
     
    for i=1:n-1
        if ratio(i,1)>0
            minimum_ratio=ratio(i,1);
            r=i;
            break;
        end
    end
    
    pivot_row = r;
    for i=r:n-1
        if ratio(i,1)>0
            if ratio(i,1)<minimum_ratio
                minimum_ratio=ratio(i,1);
                pivot_row = i;
            end
        end
    end
    
    %Printing Pivot_column
    fprintf('\nThe Most negative number in bottom row = %f',min_val);
    fprintf('\nPivot Column = %d',pivot_column);
    fprintf('\n(Since %f is the most negative number in bottom row & lies in column %d)\n',min_val,pivot_column);
    
    
    %Printing Pivot_row
    fprintf('\nThe least positive ratio = %f',minimum_ratio);
    fprintf('\nPivot row = %d',pivot_row);
    fprintf('\n(Since %f is the leat positive ratio & lies in row %d)\n\n',minimum_ratio,pivot_row);
    %disp('Pivot_row'); disp(pivot_row);
    %disp('minimum_ratio');disp(minimum_ratio);
    
    pivot_element = augmented_matrix(pivot_row,pivot_column);
    %disp('Pivot_element'); disp(pivot_element);
    fprintf('Pivot element = %f\n',pivot_element);
    fprintf('(Being the intersection of Pivot_row = %d and Pivot_column = %d)\n',pivot_row,pivot_column);
    BV(pivot_row,1) = variables(1,pivot_column);
    %disp('BV new'); disp(BV);
    
    %dividing pivot_row with Pivot_element to get new pivot_row
    for j = 1:(dv+n)
       augmented_matrix(pivot_row,j)= augmented_matrix(pivot_row,j)/pivot_element;
    end
    
    for i =1:n
        %disp('Pivot column element'); 
        pivot_column_element(i,1) = augmented_matrix(i,pivot_column);
        %disp(pivot_column_element(i,1));
    end
    
    %changing others row by row operationg
    for i= 1:n
        for j=1:(dv+n)
            multiplier = pivot_column_element(i,1);
            if i== pivot_row
                continue;
            else
                augmented_matrix(i,j) = augmented_matrix(i,j)- multiplier*augmented_matrix(pivot_row,j);
            end
            
        end
    end
    
    
    
    
    %{
    fprintf('Iteration #%d \n',k); %disp(augmented_matrix);
    
    fprintf('--------------------------------------------------------------\n');
    to print the heading of decision variables like x1,x2...
    for i=1:dv
        fprintf('\t\t x%d',i);
    end
    
    %to print the heading of slack variables like s1,s2...
    fprintf('');
    for i=1:(n-1)
        fprintf('        s%d',i);
    end
    
    %print heading for RHS or Solution
    fprintf('\t RHS/ANS');
    
    %print line 
    fprintf('\n--------------------------------------------------------------');
    
    fprintf('\n'); 
    %}
    
    %-------------disp([BV z augmented_matrix ratio]);---------------
    
    
    
    
    
    % for assigning Values of RHS to decision variables and printing them
    % after each iteration
    for i=1:dv
        check=0;
        for j=1:(n-1)
            if i==BV(j,1)
                x(i,1)=augmented_matrix(j,dv+n);
                check=1;
            end
        end
       if check==0
           x(i,1)=0;
       end
       %fprintf('x%d = %f\n',i,x(i,1));
    end
    
    % for assigning Values of RHS to slack variables and printing them
    % after each iteration
    for i=(dv+1):(dv+n-1)
        check=0;
        for j=1:(n-1)
            if i==BV(j,1)
                slack(i-dv,1)=augmented_matrix(j,dv+n);
                check=1;
            end
        end
       if check==0
           slack(i-dv,1)=0;
       end
       %fprintf('S%d = %f\n',i-dv,slack(i-dv,1));
    end
    
    % to print the value of Z
    %fprintf('Value of Z = %f\n',augmented_matrix(n,dv+n));
    end 
end