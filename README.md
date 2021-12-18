# LAB1_ISA

Nella cartella "primo_esercizio" ci sono tutti i file relativi al primo filtro, nella cartella "secondo_esercizio" ci sono tutti i file relativi al secondo filtro. 

# Lab2_ISA
La cartella è organizzata come segue:
- reports: contiene tutti i report fatti con design vision
- src: A sua volta suddivisa in:
    - Multiplier_1: Contiene i file originali del motliplicatore senza modifiche, un clock generator, un component (data_maker) per leggere i dati da file e darli al   motliplicatore, un component (data_sink) per salvare i risultati su file e la test bench  
    - Multiplier_2: Contiene tutto quello contenuto in Multiplier_1 ma come richiesto viene aggiunto uno stadio di registri all'ingresso del motliplicatore
    - Multiplier_3: Contiene tutto quello contenuto in Multiplier_2 ma come richiesto viene aggiunto uno stadio di registri all'uscita del "Significand Multiplier"
    - Multiplier_4: Contiene tutto quello contenuto in Multiplier_3 ma come richiesto al posto del simbolo "*" allochiamo un mbe_multiplier i cui component sono un booth encoder e un dadda tree. Tutto quello che serve è in questa cartella
