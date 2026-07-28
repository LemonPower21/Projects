function x = gaussnopiv(A,b)
% GAUSS Risolve il sistema A*x = b tramite Eliminazione di Gauss senza pivoting
% e successiva sostituzione all'indietro.

dim = length(b); % Calcola la dimensione del sistema (numero di equazioni/incognite)

% --- FASE 1: ELIMINAZIONE GAUSSIANA (Triangolarizzazione) ---
% Ciclo esterno sui passi di eliminazione (dalla colonna 1 alla colonna dim-1)
for k = 1:dim-1
    % Ciclo sulle righe sottostanti la diagonale (dalla riga k+1 alla riga dim)
    for i = k+1:dim
        % Calcola il moltiplicatore m_(i,k) e lo memorizza direttamente nella parte
        % inferiore della matrice A (al posto dell'elemento A(i,k) che diventerebbe 0).
        A(i,k) = A(i,k)/A(k,k);

        % Ciclo sulle colonne della riga i (da k+1 fino a dim) per aggiornare la matrice
        for j = k+1:dim
            % Modifica l'elemento A(i,j) sottraendo il prodotto del moltiplicatore per A(k,j)
            A(i,j) = A(i,j) - A(i,k)*A(k,j);
        end

        % Aggiorna anche il corrispondente elemento del termine noto b(i)
        b(i) = b(i) - A(i,k)*b(k);
    end % Fine ciclo sulle righe i
end % Fine ciclo sui passi k

% --- FASE 2: SOSTITUZIONE ALL'INDIETRO ---
% Risoluzione dell'ultima equazione (A(dim,dim)*x(dim) = b(dim))
x(dim) = b(dim)/A(dim,dim);

% Ciclo all'indietro per calcolare le componenti x(dim-1), x(dim-2), ..., x(1)
for i = dim-1:-1:1
    % Sottrae dal termine noto b(i) il prodotto scalare degli elementi già calcolati
    % e divide il risultato per l'elemento diagonale A(i,i)
    somma_noti = A(i,i+1:dim)*x(i+1:dim);
    x(i) = (b(i) - somma_noti) / A(i,i);
end % Fine ciclo sostituzione all'indietro

end % Fine della funzione