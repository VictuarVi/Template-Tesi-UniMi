= Tecnologie utilizzate
<cap3>
In questo capitolo vengono presentati alcuni suggerimenti utili per un utente LaTeX~alle prime armi.

== Generalità
<generalità>
=== La scrittura WYSIWYG vs.~WYSIWYM
<la-scrittura-wysiwyg-vs.-wysiwym>
L'acronimo WYSIWYG sta per "What You See is What You Get", e si riferisce al concetto di ottenere sulla carta testo e immagini che abbiano una disposizione grafica equivalente a quella visualizzata a schermo dal software di videoscrittura. Un esempio classico di WYSIWYG è Microsoft Word, che mostra il testo impaginato e formattato come ci si aspetta di vederlo una volta stampato.

L'acronimo WYSIWYM sta per "What You See is What You Mean", ed è il paradigma per la creazione di testi strutturati. LaTeX~è un ambiente che supporta tale paradigma. In realtà, anche Microsoft Word avrebbe la possibilità di strutturare il testo, principalmente attraverso il meccanismo degli stili, ma pochissimi utenti sfruttano tale funzionalità (ovviamente se sceglierete di scrivere la tesi in Word raccomandiamo caldamente l'uso di tali funzioni, così come le funzioni di gestione automatica dei riferimenti e della bibliografia).

I principali svantaggi di un sistema WYSIWYM sono il tempo di apprendimento, dovuto a una minore intuitività degli strumenti software, e la necessità di invocare la compilazione del documento per vederne l'aspetto definitivo. Ad esempio, in LaTeX~l'intero documento viene scritto in testo semplice, che all'interno contiene ambienti e comandi con informazioni di layout, e solo la compilazione permette di scoprire eventuali errori di sintassi e giungere, infine, alla creazione del PDF.

Le difficoltà iniziali, però, sono ampiamente compensate dai vantaggi a medio e lungo termine. Infatti, il lavoro risulterà perfettamente impaginato e strutturato, e dunque avrà un aspetto professionale. Questo riguarda non solo gli stili, che vengono applicati al testo in modo coerente con il template prescelto, ma anche aspetti tipicamente spinosi di Word, quali il posizionamento delle immagini e delle tabelle, la creazione di una bibliografia con relative citazioni nel testo, la creazione di un sommario. Diventa automatico e molto semplice, ad esempio, aggiungere un indice delle figure o delle tabelle, oppure numerare le formule espresse nel testo. Un altro aspetto su cui LaTeX~è nettamente superiore a Word è proprio la scrittura di formule matematiche, come mostrato nell'esempio qui riportato: $ x_i (n) = a_(i 1) u_1 (n) + a_(i 2) u_2 (n) + dots.h.c + a_(i J) u_J (n) thin . $

=== Risorse e strumenti
<risorse-e-strumenti>
Esiste una vastissima gamma di risorse online per avvicinarsi a LaTeX. Un buon punto di partenza è la lista messa a disposizione sul sito del TeX~Users Group (TUG).#footnote[#link("http://www.tug.org/interest.html");] Tra queste si consiglia in particolare la "Not so Short Introduction to LaTeX2e",#footnote[#link("http://mirrors.ibiblio.org/CTAN/info/lshort/");];. Per chi volesse approfondire, uno dei riferimenti bibliografici più completi è il libro di Mittelbach #emph[et al.];~@mittelbach2004latex.

In alternativa a un'installazione locale sul proprio pc, è possibile utilizzare un editor LaTeX~online, con il vantaggio di avere immediatamente a disposizione l'ambiente di sviluppo e tutti i package necessari, nonché di potere condividere il proprio progetto con il relatore di tesi. Il più diffuso editor LaTeX~online è Overleaf,#footnote[#link("http://www.overleaf.com");] dove si può trovare anche ulteriore documentazione (in particolare la guida "Learn LaTeX~in 30 minutes").#footnote[#link("https://www.overleaf.com/learn");]

Qualunque sia la risorsa utilizzata, ecco un elenco non esaustivo di argomenti di base nei quali con tutta probabilità ci si imbatterà durante la stesura della tesi.

- Formattazione del testo (grassetto, italics, dimensioni font, ecc.) e del documento (paragrafi, comandi `\chapter`, `\section`, `\tableofcontents`, ecc.).

- Elenchi: ambienti #emph[itemize] e #emph[enumerate];, pacchetti rilevanti (#emph[paralist];)

- Riferimenti incrociati: comandi `\ref`, `\pageref` e `\label`, etichette.

- Matematica: equazioni, modalità #emph[inline] e #emph[displayed];, pacchetti rilevanti (#emph[amssymb];, #emph[amsmath];).

- Figure: formati grafici, ambiente #emph[figure];, pacchetti rilevanti (#emph[graphicx];, #emph[subfloats] per figure multiple).

- Tabelle: ambienti #emph[table] e #emph[tabular];, pacchetti rilevanti (#emph[array];, #emph[multirow];, #emph[longtable];).

- Riferimenti e bibliografie (si veda più sotto la sezione~@sec:bibtex).

== Suggerimenti sull'uso di LaTeX
<sec:consigli_latex>
Fatte salve le indicazioni generali fornite nella sezione precedente, di seguito si riportano alcune osservazioni puntuali sulle domande e gli errori più tipici degli studenti alle prime armi con LaTeX.

=== Riferimenti incrociati
<riferimenti-incrociati>
Uno dei principali vantaggi di LaTeX~è la possibilità di impostare riferimenti automatici a molti elementi del documento, tra cui capitoli, sezioni, sottosezioni, tabelle, figure, equazioni, riferimenti bibliografici, e via dicendo.

Quindi il modo corretto per riferirsi, ad esempio, al secondo capitolo non è scrivere "Capitolo 2" bensì "Capitolo~@chap:stato_arte". Il risultato apparente (nel PDF) è lo stesso, mentre ci sono differenze sostanziali a livello di codice. Il vantaggio è che, se il secondo capitolo diventasse il terzo, il riferimento incrociato continuerebbe a puntare alla posizione corretta. Si pensi, per estensione, alla numerazione delle immagini, o ai riferimenti alla bibliografia.

Sintatticamente, questo richiede di inserire dei comandi `\label{mia_label}` all'interno degli elementi cui ci si vuole riferire, e dei comandi `\ref{mia_label}` dove si vuole creare il riferimento. Fa eccezione la bibliografia (si veda più sotto la sezione~@sec:bibtex).

=== Ritorni a capo
<ritorni-a-capo>
I ritorni a capo in LaTeX~possono essere effettuati in due modi: con la sintassi `\\` o con una doppia pressione del tasto di ritorno a capo. In generale, la soluzione corretta è la seconda, che equivale a usare il tasto Enter in Word. Il doppio Backslash, che corrisponde a Shift+Enter in Word, crea una nuova riga senza interruzione del paragrafo. Questo va usato solo in casi molto specifici, come nella frase seguente.

Il sito web ufficiale dell'Università degli Studi di Milano è: \
#link("https://www.unimi.it");.

In molti stili di LaTeX, un nuovo paragrafo (dopo un doppio a capo) crea un rientro della prima riga. Non c'è nulla di male nel rientro, ma se proprio lo si vuole evitare la soluzione #strong[non] è usare il doppio BackSlash! Esistono molte soluzioni più appropriate (ad esempio, dare una dimensione nulla al rientro tramite il comando `\setlength{\parindent}{0ex}`, da inserire nel preambolo della tesi).

=== Accenti
<accenti>
Scrivendo la tesi in italiano, l'uso di lettere accentate è frequente. I caratteri accentati immessi da tastiera non vengono però riconosciuti nativamente. Invece l'accento grave e acuto in LaTeX~si ottengono rispettivamente con i comandi #raw("\\`{a}") e `\'{a}.`

In alternativa è possibile specificare che si usa la codifica UTF-8, usando il comando `\usepackage[utf8]{inputenc}` nel preambolo del documento (già incluso in questo template). In questo modo i caratteri accentati immessi da tastiera verranno riconosciuti.

Nota ortografica: attenzione a non sbagliare gli accenti: si scrive "è", ma si scrive "perché".

=== Spazi tra parole
<spazi-tra-parole>
Riguardo la gestione della spaziatura tra parole, LaTeX~adotta una strategia molto elegante, che lascia uno spazio maggiorato dopo il punto di fine periodo. Un potenziale problema è che questo spazio extra viene introdotto dopo qualsiasi occorrenza del punto, indipendentemente dalla funzione sintattica, e dunque anche dopo i nomi puntati, quali "R. Schumann", o dopo le formule "ad es.", "Fig. n", "ecc." e via dicendo. Per evitarlo, questi spazi da non aumentare vanno sostituiti con alternative, quali un Backslash seguito da uno spazio (che immette un #emph[control space];) o una tilde `~` (che introduce un #emph[unbreakable space];, utile a impedire ritorni a capo intermedi).#footnote[Per una trattazione completa delle numerose varianti, si veda #link("https://tex.stackexchange.com/questions/74353/what-commands-are-there-for-horizontal-spacing");]

=== Interlinea
<interlinea>
Per aumentare la leggibilità della tesi può essere utile usare un'interlinea maggiore di 1. Un modo per ottenerlo è usare il comando `\linespread{1.6}` nel preambolo del documento (il valore $1.6$ indica interlinea doppia, il valore $1.3$ indica interlinea 1.5. Don't ask why).

=== Doppie virgolette
<doppie-virgolette>
L'uso dell'unico carattere di doppie virgolette presente sulla tastiera è assolutamente sconsigliato, in quanto non viene correttamente interpretato da LaTeX, soprattutto riguardo l'apertura delle virgolette.

La combinazione giusta da utilizzare è #raw("``") per l'apertura e `''` per la chiusura. Si noti che in entrambi i casi si tratta di doppi apostrofi ravvicinati, e non di singoli caratteri. Se si utilizza come editor TeXstudio, c'è un'opzione per sostituire automaticamente le doppie virgolette con la versione corretta in LaTeX: Opzioni $arrow.r$ Configura TeXstudio... $arrow.r$ Editore $arrow.r$ Sostituisci i doppi apici: Inglesi.

Le virgolette caporali, o francesi, si ottengono con i comandi `\guillemotleft` e `\guillemotright`, il cui risultato è questo.

=== Ambienti per scrivere codice
<ambienti-per-scrivere-codice>
Il codice all'interno dell'elaborato va scritto con carattere monospaziato e rispettando, nell'ambito del possibile, le originali regole (o buone pratiche) di indentazione.

Per farlo, esiste innanzi tutto l'ambiente verbatim, che va aperto e chiuso con i comandi `\begin{verbatim}` ed `\end{verbatim}`.

Tra le alternative, si segnala l'ambiente lstlisting, che richiede innanzi tutto di aggiungere nel preambolo `\usepackage{listings}`, e quindi di aprire e chiudere l'ambiente con i comandi `\begin{lstlisting}` ed `\end{lstlisting}`. Un esempio, relativo al calcolo del massimo comun divisore attraverso l'algoritmo di Euclide in Python, è:

```python
def MCD(a,b):
  while b != 0:
    a, b = b, a % b
  return a
```

Se dopo l'apertura dell'ambiente si specifica tra parentesi quadrate il linguaggio adottato, ad esempio con la sintassi `\begin{lstlisting}[language=Python]`, si ottiene automaticamente l'evidenziazione del codice:

```python
def MCD(a,b):
  while b != 0:
    a, b = b, a % b
  return a
```

L'elenco dei linguaggi supportati e le opzioni avanzate per personalizzare la visualizzazione del codice si trovano all'indirizzo #link("https://www.overleaf.com/learn/latex/Code_listing#Reference_guide");.

Si consideri anche la possibilità di importare interi file di codice attraverso la sintassi `\lstinputlisting[language=nomelinguaggio]{filesorgente}`.

In fine, se lstlisting non dovesse incontrare il vostro gusto, si segnala che in alternativa è possibile usare il package minted.

=== Figure
<figure>
In tutti i casi in cui sia possibile (schemi a blocchi, plot di dati, ecc.), è opportuno che le figure siano in formato vettoriale (eps, pdf) per aumentarne la leggibilità. Nel caso di figure prodotte da software esterno (ad esempio, grafici esportati in eps o pdf da Matlab), è consigliabile conservare tutti i sorgenti e i dati utilizzati per generarle: in questo modo sarà possibile ricreare le figure quando necessario.

Le figure devono sempre avere riferimenti nel testo, realizzati assegnando un'etichetta alla figura mediante il comando `\label{nomeEtichetta}` subito prima della chiusura dell'ambiente `figure`, e utilizzandola nel testo mediante il comando `\ref{nomeEtichetta}`. Il medesimo discorso vale anche per Tabelle ed Equazioni.

Si evitino espressioni del tipo "come visibile nella figura seguente" in favore di riferimenti esatti del tipo "come visibile in Fig~@fig:ideas2text" in quanto LaTeXposiziona le immagini sulla pagina seguendo regole tipografiche, che non corrispondono necessariamente alla posizione di inserimento nel sorgente del documento.

=== Commenti e revisione
<commenti-e-revisione>
Overleaf mette a disposizione delle funzionalità di revisione, come ad esempio la possibilità di inserire commenti relativi a punti specifici del sorgente, senza che questi intacchino il sorgente stesso o il file compilato. Alcuni professori preferiscono usare questo strumento, altri invece preferiscono lasciare traccia dei commenti direttamente nel codice, in modo che vengano versionati insieme al sorgente e compaiano sul PDF compilato.

In caso si preferisca commentare il codice nel sorgente invece che usare le funzioni di review di Overleaf è necessario aumentare i margini del documento per permettere alle note di stare accanto al corpo del testo, e successivamente importare il package todonotes. Per fare ciò è necessario aggiungere nel preambolo i seguenti comandi (su due righe ed in questo ordine) `\setlength {\marginparwidth }{2cm}` e `\usepackage{todonotes}`. A tesi completata è possibile nascondere i commenti senza doverli eliminare manualmente modificando l'inclusione del package come segue: `\usepackage[disable]{todonotes}`.

== BibTeX
<sec:bibtex>
=== Generalità
<generalità-1>
Esistono più modi per inserire una bibliografia in LaTeX. Si consiglia fortemente l'utilizzo del sistema . Questo consente di aggiungere, rimuovere e modificare voci di bibliografia in maniera efficiente, di formattarle, di riordinarle a piacere e aggiornare automaticamente i corrispondenti riferimenti nel testo, ecc.

Una guida introduttiva e completa è "Tame the BeaST".#footnote[Accessibile da #link("http://www.tug.org/interest.html");] In estrema sintesi, i passi per gestire una bibliografia tramite sono essenzialmente tre.

+ Salvare i riferimenti bibliografici come entry di uno o più file con l'estensione .bib (si veda ad esempio il file `bibliografia.bib`, parte di questo template). Gli entry sono scritti in un formato specifico, in particolare ogni entry ha una propria etichetta testuale che lo identifica univocamente.

+ Creare la bibliografia alla fine del documento o dove desiderato, usando il comando `\bibliography{file1.bib,file2.bib,...}`. È possibile inoltre specificare uno stile bibliografico attraverso il comando `\biblographystyle{...}`.

+ All'interno del testo, riferirsi a una voce di bibliografia tramite il comando \
  `\cite{etichetta_entry}`. Si noti che una voce bibliografica non viene inclusa in bibliografia in assenza di una citazione all'interno del testo (coerentemente con quanto discusso nella sezione~@sec:biblio).

È consigliabile cominciare a costruire la propria bibliografia in formato bib a mano a mano che si analizza lo stato dell'arte, invece che rimandare alla stesura finale della tesi.

=== Strumenti
<strumenti>
Un file .bib è un file di testo e può quindi essere gestito con un qualsiasi text editor. Esistono comunque molti tool più evoluti per gestire bibliografie in formato bib. Un'applicazione installabile localmente sul proprio pc è JabRef.#footnote[#link("http://www.jabref.org");];. Oppure esistono tool online, come Zotero,#footnote[#link("http://www.zotero.org");] che forniscono molte funzionalità tra cui l'esportazione di bibliografie in formato bib.

Peraltro, anche Google Scholar esporta automaticamente citazioni in formato bib cliccando sul link Cita (icona con doppie virgolette) e scegliendo l'opzione nella parte bassa della finestra che si apre. #strong[Attenzione] però: spesso i bib esportati da Scholar sono incompleti o sporchi, è sempre consigliabile controllarne la correttezza.

Infatti, si preferiscono, in generale, i metadati raccolti dalla sorgente primaria della risorsa (es. sito ufficiale della pubblicazione) rispetto a quelli presentati dai motori di ricerca. Nel caso in cui i siti ufficiali non propongano il formato , esistono convertitori, facilmente reperibili e utilizzabili via web, per convertire in la maggior parte dei formati (es. RIS). Nei rari casi in cui non siano disponibili i dati in alcun formato machine readable, potete compilare manualmente l'entry voi stessi. Per un riferimento su tipi di entry e i relativi campi, potete consultare #link("https://bibtex.eu");.

I più "smanettoni" possono addentrarsi a piacere in funzionalità avanzate. Ad esempio è possibile creare bibliografie multiple.#footnote[Un possibile modo viene illustrato qui: #link("https://bit.ly/2wI3Y7p");] Esiste anche il pacchetto `biblatex`, che fornisce una reimplementazione completa delle funzionalità bibliografiche di LaTeX-, offrendo maggiore flessibilità e mantenendo compatibilità all'indietro con il formato bib.
