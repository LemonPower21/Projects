function x = indietroTRIU(A,b)
% INDIETROTRIU Risolve il sistema lineare A*x = b usando la sostituzione all'indietro.
% Presume che A sia una matrice triangolare superiore di dimensione dim x dim
% e b sia il vettore dei termini noti di dimensione dim x 1.

dim = length(b);         % Calcola la dimensione del sistema (numero di equazioni/incognite)

% 1. Risoluzione dell'ultima equazione (A(dim,dim)*x(dim) = b(dim))
% Essendo la matrice triangolare superiore, l'ultima riga contiene solo un elemento non nullo.
x(dim) = b(dim)/A(dim,dim);

% 2. Ciclo all'indietro per determinare le incognite x(dim-1), x(dim-2), ..., x(1)
for i = dim-1:-1:1

    % Calcola la somma dei prodotti degli elementi già noti della riga i-esima:
    % somma_noti = A(i, i+1)*x(i+1) + A(i, i+2)*x(i+2) + ... + A(i, dim)*x(dim)
    somma_noti = A(i,i+1:dim)*x(i+1:dim);

    % Ricava la componente i-esima x(i) sottraendo la somma temporanea dal termine noto b(i)
    % e dividendo il risultato per l'elemento sulla diagonale principale A(i,i).
    x(i) = (b(i) - somma_noti)/A(i,i);

end                      % Fine del ciclo for

end