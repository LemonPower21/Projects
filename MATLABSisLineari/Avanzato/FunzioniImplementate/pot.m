function [autoval_max, v_proprio, iter] = pot(Mat, v_init, toll, max_iter)
% POTENZE Calcola l'autovalore di modulo massimo e il relativo autovettore
% usando il metodo delle potenze approssimato.
%
% INPUT:
% - Mat      : Matrice quadrata
% - v_init   : Vettore di partenza (stima iniziale)
% - toll     : Tolleranza per il criterio di arresto
% - max_iter : Numero massimo di iterazioni consentite
%
% OUTPUT:
% - autoval_max : Approssimazione dell'autovalore dominante
% - v_proprio   : Autovettore associato (normalizzato)
% - iter        : Numero di iterazioni effettuate prima della convergenza

% Normalizzazione del vettore di partenza per evitare problemi di overflow/underflow
v_proprio = v_init / norm(v_init);

% Inizializzazione della stima dell'autovalore al passo precedente
autoval_old = 0;

% Ciclo principale delle iterazioni
for iter = 1:max_iter

    % Applicazione dell'operatore matriciale (prodotto matrice-vettore)
    v_temp = Mat * v_proprio;

    % Calcolo del quoziente di Rayleigh per stimare l'autovalore dominante:
    % autoval_max = (v_proprio' * Mat * v_proprio) / (v_proprio' * v_proprio)
    % siccome norm(v_proprio) == 1, il denominatore vale 1.
    autoval_max = v_proprio' * v_temp;

    % Normalizzazione del nuovo vettore per l'iterazione successiva
    v_proprio = v_temp / norm(v_temp);

    % Controllo del criterio di arresto basato sullo scarto relativo dell'autovalore
    if abs(autoval_max - autoval_old) <= toll * abs(autoval_max)
        break % Convergenza raggiunta: interrompe il ciclo anticipatamente
    end

    % Aggiornamento dell'autovalore di riferimento per il prossimo controllo
    autoval_old = autoval_max;

end % Fine del ciclo for

end % Fine della funzione