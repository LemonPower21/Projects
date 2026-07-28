function [L, U] = lunop(A)
% LU_NOPIVOT Calcola la decomposizione A = L*U senza pivoting.
% Restituisce:
% - L: matrice triangolare inferiore con 1 sulla diagonale
% - U: matrice triangolare superiore

n = size(A, 1);

% --- Fase di Fattorizzazione ---
for k = 1:n-1
    for i = k+1:n
        % Salviamo il moltiplicatore in A(i,k)
        A(i,k) = A(i,k) / A(k,k);

        % Aggiorniamo il resto della riga
        for j = k+1:n
            A(i,j) = A(i,j) - A(i,k)*A(k,j);
        end
    end
end

% --- Estrazione delle matrici L ed U ---

% U contiene la parte triangolare superiore di A (compresa la diagonale)
U = triu(A);

% L contiene i moltiplicatori nella parte inferiore stretta (sotto la diagonale),
% più la matrice identità eye(n) per mettere tutti 1 sulla diagonale principale.
L = tril(A, -1) + eye(n);

end