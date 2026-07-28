function x = avantiTRIL(L,b)
% AVANTITRIL Risolve il sistema lineare L*x = b usando la sostituzione in avanti.
% Presume che L sia una matrice triangolare inferiore di dimensione dim x dim
% e b sia il vettore dei termini noti di dimensione dim x 1.

dim = length(b);         % Calcola la dimensione del sistema (numero di equazioni/incognite)

% 1. Risoluzione della prima equazione (L(1,1)*x(1) = b(1))
% Essendo la matrice triangolare inferiore, la prima riga ha un solo elemento non nullo.
x(1) = b(1)/L(1,1);

% 2. Ciclo in avanti per determinare le incognite x(2), x(3), ..., x(dim)
for i = 2:dim

    % Calcola la somma dei prodotti dei termini già noti della riga i-esima:
    % somma_noti = L(i, 1)*x(1) + L(i, 2)*x(2) + ... + L(i, i-1)*x(i-1)
    somma_noti = L(i, 1:i-1)*x(1:i-1);

    % Ricava la componente i-esima x(i) sottraendo la somma temporanea dal termine noto b(i)
    % e dividendo il risultato per l'elemento diagonale L(i,i).
    x(i) = (b(i) - somma_noti)/L(i,i);

end                      % Fine del ciclo for

end