A = [ 4,  1,  1;
    1,  3, -1;
    1, -1,  2 ];
b = [1;1;1]


% Ax=b ----> LUx = Pb --->  (y=Ux) y = L\(P*b), x = U\y

%SOLUZIONE SISTEMA
[L,U,P] = lu(A)
y = L \ (P * b);
x = U \ y

