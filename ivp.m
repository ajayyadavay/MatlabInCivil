function [ df ] = ivp( x,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    df=input('enter dy/dx : ');
    [x,y]=ode45(@ivp,[1:0.5:3],4.2)
end

