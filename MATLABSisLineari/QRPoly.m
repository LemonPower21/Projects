x = [1.0; 2.0; 3.0; 4.0; 5.0];
y = [2.2; 2.8; 4.5; 5.1; 6.7];

% --- METODO 1: QR ---
A = [x,ones(5,1)];   % y = c1*x + c2
b = y;

[Q, R] = qr(A)
% QRx = b ---> Rx = (Q'b) (poichè Q ortogonale)

%Q (m,m) ORTOGONALE
%R (m,n) TRIU

c_qr = R \ (Q' * b)


% --- METODO 2: polyfit & polyval ---
p = polyfit(x, y, 1)

xp = linspace(0.5, 5.5, 100);
yp = polyval(p, xp);

figure;
%PUNTI
plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5, 'DisplayName', 'Dati');
hold on;
%RETTA O POLINOMIO TROVATO
plot(xp, yp, 'b-', 'LineWidth', 2, 'DisplayName', sprintf('Retta: y = %.2fx + %.2f', p(1), p(2)));
grid on;