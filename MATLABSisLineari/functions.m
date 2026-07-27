clear all
clc
close all

MATRICEPERFARETUTTO = [1 2 3; 4 5 6; 7 8 9]

% 1. Rango della matrice
rango = rank(MATRICEPERFARETUTTO)

% 2. Determinante della matrice
determinante = det(MATRICEPERFARETUTTO)

% 3. Kernel (Nucleo / Spazio Nullo)
bker = null(MATRICEPERFARETUTTO)

% 4. Immagine (Spazio delle Colonne - Base ortonormale dell'immagine)
bim = orth(MATRICEPERFARETUTTO)

% 5. Calcolo dei soli Autovalori
autov = eig(MATRICEPERFARETUTTO)

% 6. Calcolo contemporaneo di Autovettori (matrice V) e Autovalori (matrice diagonale D)
[V, D] = eig(MATRICEPERFARETUTTO)

% 7. Calcolo del singolo autovalore piu vicino al target sigma = 0.5 usando eigs
STIMA = eigs(MATRICEPERFARETUTTO, 1, 0.5)


%ECCEZIONI EIGS
%1. AUTOVALORI COMPLESSI
%2. PERFETTA COINCIDENZA TRA SIGMA E AUTOVALORE
%3. SIGMA ESATTAMENTE A META' TRA DUE AUTOVALORI  S=0.5 e A1=1 A2=0
















% FUNZIONI
funz(5)   %factorial(5)
1*2*3*4*5
factorial(5)
