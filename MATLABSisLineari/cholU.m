A = [ 4,  1,  1;
    1,  3, -1;
    1, -1,  2 ];
b = [1;1;1]


R = chol(A)

%R'Rx = b --->   (y= Rx) ---> y= R'\b , x = R\y

y = R'\b;
x = R\y