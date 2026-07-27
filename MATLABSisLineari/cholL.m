A = [ 4,  1,  1;
    1,  3, -1;
    1, -1,  2 ];
b = [1;1;1]


L = chol(A,"lower")

%LL'x = b ---> y= R'\b , x = R\y

y = L\b;
x = L'\y