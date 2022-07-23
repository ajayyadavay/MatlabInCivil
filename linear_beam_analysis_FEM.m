function linear_beam_analysis_FEM(node,E,I,l,Support,Applied_Force)
    %(number of nodes, elasticity, Moment of Inertia, Lenfth, Boundary
    %condition, Applied Forces)
    % refer example no. 28 of page 142 of Computational technique book
    % Sign convenction of force and moment: 
    % Anticlockwise moment is positive and Upward force is positive
    % Example1: put the following data and you will get reaction-
    % node = 3; E = [2*10^8 2*10^8]; I = [5*10^-6 5*10^-6]; l = [3 3]; Support = ["F"; "R"; "N"]; Applied_Force = [0;0;0;0;15;40]
	% For support F = Fixed, R = Roller and N = No_Support;
    % Example2: put the following data and you will get reaction-
    % node = 3; E = [20*10^8 20*10^8]; I = [5*10^-6 5*10^-6]; l = [8 6]; Support = ["F"; "R"; "R"]; Applied_Force = [-20.51;-35.156;-69.49;-78.906;-60;60]
    % Example3: put the following data and you will get reaction-
    % node = 3; E = [1 1]; I = [1 1]; l = [5 5]; Support = ["F"; "N"; "R"]; Applied_Force = [0;0;-100;0;0;41.667]
    % Here dof = 2 * node because
    % this program considers only vertical force and rotational i.e. the
    % axial force is not considered so, for each node we will have only two
    % degree of freedom
    % function linear_beam_analysis_FEM(E,I,l,node,nodal_force,boundary_condition)
    dof=2 * node; %dof=degree of freedom =  2 times no. of node;E= matrix of modulus of elasticity of beam portions
    element=node-1; % l is matrix of length of beam protions between various nodes
    % I is modulus of rigidity in matrix form of beam portions
    % nodal force is matrix of forces acting at nodes
    %count_j=0;count_m=0;  j and m are rows and columns of stiffness matrix
    k=zeros(dof);
    ke=zeros(4); % For one element there are 4 degree of freedom (2 dof for each node)
                 % 4 dofs are v1, theta_1, v2, theta_2 respectively
    u=zeros(dof);
    for i=1:element
        count_j=0;
        for j=(2*i-1):(2*i+2) 
            count_j=count_j+1;count_m=0;
           % disp('j=');
           % disp(count_j);
            for m=(2*i-1):(2*i+2)
                count_m=count_m+1;
              %   disp('m=');
                %disp(count_m);
                if (count_j==1 && count_m==1) ...
                        || count_j==3 && count_m==3
                   % ke(2*i-1,2*i+2)=12*E(i)*I(i)/(l(i)^3);%12EI/l^3;ke(2*element-1,2*element+2)=12*E(1)*I(1)/(l(1)^3)
                    ke(j,m)=12*E(i)*I(i)/(l(i)^3);
                   fprintf('ke %d%d = %f\n',j,m,ke(j,m));
                   k(j,m) = k (j,m) + ke(j,m);
                    
                elseif count_j==1 && count_m==2 ...
                        || count_j==1 && count_m==4 ...
                        || count_j==2 && count_m==1 ...
                        || count_j==4 && count_m==1
                     ke(j,m)=6*E(i)*I(i)/(l(i)^2);%6EI/l^2; ke(2*element-1,2*element+2)=6*E(1)*I(1)/(l(1)^2)
                    % fprintf('ke %d%d = %f\n',j,m,ki(2*i-1,2*i+2));
                   fprintf('ke %d%d = %f\n',j,m,ke(j,m));
                   k(j,m) = k (j,m) + ke(j,m);
                     
                elseif count_j==1 && count_m==3 ...
                    || count_j==3 && count_m==1
                    ke(j,m)=-12*E(i)*I(i)/(l(i)^3);%-12EI/l^3;ke(2*element-1,2*element+2)=-12*E(1)*I(1)/(l(1)^3)
                    % fprintf('ke %d%d = %f\n',j,m,ki(2*i-1,2*i+2));
                      fprintf('ke %d%d = %f\n',j,m,ke(j,m));
                      k(j,m) = k (j,m) + ke(j,m);
                     
                 elseif count_j==2 && count_m==2 ...
                     || count_j==4 && count_m==4
                   ke(j,m)=4*E(i)*I(i)/(l(i));%4EI/l;ke(2*element-1,2*element+2)=4*E(1)*I(1)/(l(1))
                     %fprintf('ke %d%d = %f\n',j,m,ki(2*i-1,2*i+2));
                       fprintf('ke %d%d = %f\n',j,m,ke(j,m));
                       k(j,m) = k (j,m) + ke(j,m);
                     
                  elseif count_j==2 && count_m==3 ...
                     || count_j==3 && count_m==2 ...
                     || count_j==3 && count_m==4 ...
                     || count_j==4 && count_m==3
                    ke(j,m)=-6*E(i)*I(i)/(l(i)^2);%-6EI/l^2;ke(2*element-1,2*element+2)=-6*E(1)*I(1)/(l(1)^2)
                   %  fprintf('ke %d%d = %f\n',j,m,ki(2*i-1,2*i+2));
                   fprintf('ke %d%d = %f\n',j,m,ke(j,m));
                   k(j,m) = k (j,m) + ke(j,m);
                     
                   elseif count_j==2 && count_m==4 ...
                     || count_j==4 && count_m==2
                    ke(j,m)=2*E(i)*I(i)/(l(i));%2EI/l;ke(2*element-1,2*element+2)=2*E(1)*I(1)/(l(1))
                    %  fprintf('ke %d%d = %f\n',j,m,ki(2*i-1,2*i+2));
                    %disp('ke');disp(ke(2*i-1,2*i+2));
                     fprintf('ke %d%d = %f\n',j,m,ke(j,m));
                     k(j,m) = k (j,m) + ke(j,m);
                     
                end
            end
        end
    end
   disp('Global stiffness matrix [K] = ');
   disp(k);
   BC = zeros(dof,1); % column matrix of boundary condition
   %Support = ["Fixed"; "Roller"; "Roller"];
   for i = 1:node
        if(Support(i,1) == "R")
               BC(2*i,1) = 1;
        elseif(Support(i,1) == "N")
            BC(2*i-1,1) = 1;
            BC(2*i,1) = 1;
        end
   end
   disp('Boundary Condition matrix [BC] = ');
   disp(BC);
   n_zeros_BC = sum(BC(:)==0); %This gives number of zero in matrix BC
   Reduced_Mat = zeros(dof - n_zeros_BC);
   RM_row = 1; 
   for i = 1:dof
       RM_col = 1;
       for j = 1:dof
           increase_row = 0;
           if(BC(i,1) == 1 && BC(j,1) == 1)
               Reduced_Mat(RM_row, RM_col) = k(i,j);
               RM_col = RM_col + 1;
               increase_row = 1; %it means increase row of reduced_Mat is set to true
           end
       end
       if(increase_row == 1)
           RM_row = RM_row + 1;
       end
   end
   disp('Reduced Global stiffness matrix [K] = ');
   disp(Reduced_Mat);
   Force = zeros(dof - n_zeros_BC,1); %create column matrix of applied force only when there is boundar condition of 1
   % when BC is 1 then it means there is rotation or displacement
   Force_row = 1;
   for i = 1:dof
       if(BC(i,1) == 1)
       Force(Force_row, 1) = Applied_Force(i,1);
       Force_row = Force_row + 1;
       end
   end
   displacement = inv(Reduced_Mat) * Force; %#ok<*MINV>
   disp('Displacement matrix [Delta] = ');
   disp(displacement);
   Final_Displacement = BC;
   d_row = 1;
   for i = 1:dof
       if(BC(i,1) == 1)
       Final_Displacement(i,1) = displacement(d_row, 1);
       d_row = d_row + 1;
       end
   end
   disp('Final Displacement matrix [F_Delta] = ');
   disp(Final_Displacement);
   Reaction = k * Final_Displacement - Applied_Force;
   disp('Reaction matrix [R] = ');
   disp(Reaction);
end