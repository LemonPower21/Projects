function [autoval_prox, v_proprio, iter] = potinv(Mat, shift, v_init, toll, max_iter)
% POTENZE_INVERSE Calcola l'autovalore di una matrice più vicino al valore 'shift'
% (e il relativo autovettore) usando il metodo delle potenze inverse con shift.
%
% INPUT:
% - Mat      : Matrice quadrata d'ingresso
% - shift    : Valore di shift 'p' vicino a cui cercare l'autovalore
% - v_init   : Vettore di partenza (stima iniziale)
% - toll     : Tolleranza per il criterio di arresto
% - max_iter : Numero massimo di iterazioni consentite
%
% OUTPUT:
% - autoval_prox : Approssimazione dell'autovalore più vicino a 'shift'
% - v_proprio    : Autovettore associato (normalizzato)
% - iter         : Numero di iterazioni effettuate prima della convergenza

% Rileva la dimensione della matrice quadrata (numero di righe/colonne)
dim_mat = size(Mat, 1);

% Normalizzazione del vettore iniziale per evitare problemi di overflow/underflow
v_proprio = v_init / norm(v_init);

% Inizializzazione della stima dell'autovalore al valore di shift scelto
autoval_old = shift;

% Fattorizzazione LU con pivoting della matrice shiftata (Mat - shift*I)
% Viene calcolata UNA SOLA VOLTA fuori dal ciclo per ottimizzare i calcoli.
[Mat_L, Mat_U, Mat_P] = lu(Mat - shift * eye(dim_mat));

% Ciclo principale delle iterazioni
for iter = 1:max_iter

    % Risoluzione del sistema triangolare inferiore Mat_L * v_interm = Mat_P * v_proprio
    v_interm = Mat_L \ (Mat_P * v_proprio);

    % Risoluzione del sistema triangolare superiore Mat_U * v_temp = v_interm
    % Equivalente a risolvere (Mat - shift*I) * v_temp = v_proprio
    v_temp = Mat_U \ v_interm;

    % Stima dell'autovalore più vicino allo shift tramite il quoziente di Rayleigh inverso:
    % autoval_prox = shift + 1 / (v_proprio' * v_temp)
    autoval_prox = shift + 1 / (v_proprio' * v_temp);

    % Normalizzazione del nuovo vettore per l'iterazione successiva
    v_proprio = v_temp / norm(v_temp);

    % Controllo del criterio di arresto basato sullo scarto relativo dell'autovalore
    if abs(autoval_prox - autoval_old) <= toll * abs(autoval_prox)
        break % Convergenza raggiunta: interrompe il ciclo anticipatamente
    end

    % Aggiornamento dell'autovalore di riferimento per il prossimo controllo
    autoval_old = autoval_prox;

end % Fine del ciclo for

end % Fine della funzione