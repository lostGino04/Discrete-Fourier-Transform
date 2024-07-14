% Questo programma in matlab calcola la Trasformata Discreta di Fourier di
% un segnale definito qui sotto da f minuscolo, che può essere una semplice
% funzione seno oppure un'onda quadra o anche un segnale audio o radio.

clear
close all
clc

% N serve a definire quanto "fitta" vogliamo la funzione e quante
% iterazioni dell'algoritmo della DFT vogliamo compiere. "freq" è la
% frequenza in Hz. "omega" è la pulsazione. "y" è un vettore riga
% contenente i valori della funzione calcolati nei punti del vettore "t",
% che sono N punti da 0 a 1 secondo equispaziati.

N = 30000;
freq = 10000;
omega = 2*pi*freq;
f = @(t) sin(omega*t); 
t = linspace(0,1,N);
y = f(t);

% Inizializziamo un vettore vuoto lungo N.

F = zeros(1,N);

% Qui avviene tutto il calcolo della trasformata, sotto attraverso due cicli
% for, molto lento e dispendioso computazionalmente, subito prima invece
% fatto con calcolo matriciale (cosa in cui matlab è molto "bravo"). "tic"
% e "toc" servono a vedere quanto tempo ci impiega matlab a fare tutti i
% calcoli.

tic
for k = 1:N
    F(k) = sum(y(1:N).*exp(-1i*2*pi*(k-1)*((1:N)-1)/N));
end
toc

%for k = 1:N
%    for n = 1:N
%        F(k) = F(k) + y(n) * exp(-1i * 2 * pi * (k-1) * (n-1) / N);
%    end
%end

% Sezione per pulire i dati appena calcolati e mostrarli bene a schermo. La
% prima istruzione serve a proporzionare le somme appena calcolate, la
% seconda istruzione serve a prendere solo la parte positive, dato che la
% trasformata di Fourier è simmetrica rispetto allo 0. La terza istruzione
% definisce una frequenza di campionamento per il segnale. La quarta
% definisce il vettore frequenze per l'asse delle ascisse. La quinta
% istruzione, come la seconda, toglie la simmetria.

F = F/N;
F = F(1:N/2);
fs = 2*N;
frequenze = (0:N-1)*(fs/N);
frequenze = frequenze(1:N/2);

% Questa sezione è per plottare a schermo il grafico della trasformata
% appena calcolata.

plot(frequenze, abs(F));
xlabel("Spettro delle frequenze (Hz)");
ylabel("Ampiezza");

% Vera fft di matlab, decommentare per fare una comparazione con la DFT
% calcolata a mano.

%Fm = fft(y, N);
%plot(frequenze, abs(Fm(1:N/2)))
%xlabel("Spettro delle frequenze (Hz)");
%ylabel("Ampiezza");