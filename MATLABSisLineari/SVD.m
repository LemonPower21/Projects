clear all
clc  
close all
%RANGO NON MASSIMO

%\ --> Adattivo ---> Pone a zero soluzioni ripetute
% pinv() ---> Risolve con SVD

% USV'x = b  ---> SV'x = U'b ---> Sy = c


%U (m,m) ORTOGONALE
%S (m,n) DIAGONALE
%V (n,n) ORTOGONALE

A = [ 1,  2,  3;
    2,  4,  6;
    1,  0,  1;
    0,  1,  1 ];

% Vettore dei termini noti b (4x1)
b = [ 1;
    3;
    2;
    0 ];

[U, S, V] = svd(A);


c = U'*b;
y = S\c;
x = V*y



%SOLUZIONE CON PENROOSE
%Ax* = b ----> x* = pinv(A)*b
x_pinv = pinv(A) * b