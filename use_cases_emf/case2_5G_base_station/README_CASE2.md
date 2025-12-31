# CASO 2: Stazione Base 5G/LTE su Tetto Edificio

## 📋 Scenario

Un operatore telecom (es. TIM, Vodafone, WindTre) vuole installare una **stazione radio base (BTS)** macro-cell sul tetto di un edificio residenziale di 6 piani. I residenti del palazzo e degli edifici vicini sono preoccupati per l'esposizione ai campi elettromagnetici a radiofrequenza (RF).

**Contesto reale**: Autorizzazione ARPA/ISPRA, comunicazione cittadini, opposizioni locali, rilascio licenze comunali.

---

## 📡 Parametri Tecnici

### Antenna
- **Tipo**: Antenna pannello settoriale (copertura 120°)
- **Frequenza**: 2100 MHz (LTE Band 1)
- **EIRP**: 2000 W (equivalente radiato isotropico)
- **Guadagno**: ~18 dBi tipico
- **Potenza trasmettitore**: ~100-150 W
- **Altezza installazione**: 25 m (tetto 6 piani + palo 3-4m)

### Caratteristiche Fascio
- **Beamwidth orizzontale**: 65° (settore)
- **Beamwidth verticale**: 8° (stretto)
- **Tilt elettrico**: 6° verso il basso
- **Polarizzazione**: Doppia (±45°)

### Geometria
```
          25m ─┐         ▶ Fascio principale
                │ ┌─▶      (tilt -6°)
          ┌─────┴─┤
    6°    │ ANTENNA│
     ╲    │  ╱╲    │
      ╲   └────────┘
       ╲  │ Edificio │  
        ╲ │   BTS    │   
          └──────────┘ 0m
              ↑ 20m ↑
          [EDIFICIO VICINO]
          (6 piani, 18m)
```

---

## 🎯 Obiettivo Analisi

Verificare conformità al **DPCM 8 luglio 2003** italiano per campi RF:

| Limite | Valore | Applicazione |
|--------|--------|--------------|
| **Esposizione** | 20 V/m | Mai superabile |
| **Attenzione** | 6 V/m | Permanenza >4h |
| **Qualità** | 6 V/m | Nuove installazioni |

> ⚠️ Per **ambienti abitativi** (balconi, finestre) si applica il limite di **6 V/m**

**Conversione**: 6 V/m ≈ 0.095 W/m² (densità di potenza)

---

## 📊 Risultati Attesi

Il programma calcola:

1. **Distribuzione campo elettrico** in piano verticale davanti all'antenna
2. **Valori ai balconi** dell'edificio vicino (piani 3-6)
3. **Profilo campo vs distanza** al piano più esposto
4. **Zone di esclusione** (E > 6 V/m)

### Output Tipico
```
═══════════════════════════════════════════════════════════
CAMPO ELETTRICO ALL'EDIFICIO VICINO (d=20m):

  Piano  │  Altezza  │  E [V/m]  │  Status
  ───────┼───────────┼───────────┼────────────────
    3    │   9 m     │   3.42    │  ✓ OK
    4    │  12 m     │   4.85    │  ✓ OK
    5    │  15 m     │   5.12    │  ✓ OK
    6    │  18 m     │   4.20    │  ✓ OK

VERIFICA CONFORMITÀ:
  ✓ CONFORME (< 6 V/m)
  → Installazione autorizzabile
═══════════════════════════════════════════════════════════
```

---

## 📈 Interpretazione Grafici

### Grafico Sinistro: Distribuzione Campo 2D
- **Asse X**: Distanza orizzontale [m]
- **Asse Y**: Altezza [m]
- **Colori**: Rosso = campo alto, Blu scuro = campo basso
- **Contorno bianco**: Isolinea 6 V/m (limite)

**Cosa cercare:**
- Il **fascio principale** (freccia rossa) punta verso il basso
- L'**edificio vicino** (rettangolo blu) deve essere in zona <6 V/m
- La **forma del fascio** è ellittica stretta verticalmente

**Interpretazione:**
- Campo **massimo** davanti antenna a ~10-30m distanza
- Campo **decresce** rapidamente sopra/sotto asse fascio
- Ai lati (fuori settore 65°) campo molto basso

### Grafico Destro: Profilo Campo al 4° Piano
- **Asse X**: Distanza dall'antenna [m]
- **Asse Y**: Campo elettrico E [V/m]
- **Linea blu**: Intensità campo reale
- **Linea rossa tratteggiata**: Limite 6 V/m

**Cosa cercare:**
- Il picco campo è tipicamente a **15-40m** dall'antenna
- Oltre 50m il campo scende rapidamente
- L'edificio vicino (linea magenta) deve essere sotto limite rosso

---

## 🔍 Fattori che Influenzano il Campo

1. **Tilt dell'antenna** (↑ tilt → campo più basso ai piani alti vicini)
   - Tilt elettrico: 6° tipico
   - Tilt meccanico: opzionale
   - Tilt totale ottimale: 6-10°

2. **Distanza edificio vicino**
   - <10m: Possibili superamenti
   - 10-30m: Zona critica, verificare
   - >30m: Generalmente OK

3. **Potenza EIRP** (↑ potenza → ↑ campo proporzionalmente)
   - Variabile con traffico utenti
   - Picco ore pomeridiane/sera
   - Media temporale <100% potenza

4. **Frequenza**
   - 800 MHz (LTE Band 20): propagazione migliore
   - 2100 MHz (Band 1): questo caso
   - 3600 MHz (5G): attenuazione maggiore

---

## 📏 Distanze di Sicurezza Tipiche

| Distanza edifici | EIRP 2000W | Raccomandazione |
|------------------|------------|-----------------|
| <10 m | ⚠️ Critico | Verifica accurata richiesta |
| 10-20 m | ⚠️ Attenzione | Questo caso - verificare piani alti |
| 20-30 m | ✓ Generalmente OK | Misure post-installazione consigliate |
| >30 m | ✓ OK | Nessuna criticità |

> 💡 **Regola pratica**: BTS urbane rispettano limiti se edifici abitati >15m

---

## ⚖️ Aspetti Normativi

### Italia (DPCM 8/7/2003)
- **Ambito**: 100 kHz - 300 GHz
- **Misurazione**: Media 6 minuti, valore efficace
- **Procedura**: Parere preventivo ARPA obbligatorio
- **Catasto**: Inserimento in catasto impianti RF

### Iter Autorizzativo Tipico
1. **Progetto tecnico** con calcoli previsionali campo EM
2. **Domanda comune** per autorizzazione edilizia
3. **Valutazione ARPA**: verifica calcoli e limiti
4. **Eventuale sopralluogo** pre-installazione
5. **Misure strumentali** post-installazione (entro 6 mesi)
6. **Collaudo finale** e inserimento catasto

---

## 🚦 Decisioni e Azioni

### Se E < 6 V/m a tutti i balconi:
✅ **AUTORIZZARE** installazione
- Proseguire con iter standard
- Misure post-installazione per conferma
- Comunicazione cittadini con dati oggettivi

### Se 6 V/m < E < 20 V/m (raro a >15m):
⚠️ **MITIGAZIONI RICHIESTE**

**Opzioni tecniche:**
1. **Aumentare tilt elettrico** (es. 6° → 10°)
   - Pro: Semplice, no costi
   - Contro: Possibile riduzione copertura
   
2. **Ridurre EIRP** (es. 2000W → 1500W)
   - Pro: Immediato
   - Contro: Riduzione capacità rete
   
3. **Spostare antenna** (altro lato tetto, altezza diversa)
   - Pro: Può risolvere completamente
   - Contro: Costi aggiuntivi
   
4. **Antenna direttiva** con front-to-back ratio maggiore
   - Pro: Riduce retro-irradiazione
   - Contro: Cambio antenna

### Se E > 20 V/m (molto raro):
❌ **NON AUTORIZZABILE**
- Riposizionamento obbligatorio
- Revisione progetto completa

---

## 🔧 Come Eseguire

```matlab
% In MATLAB:
run('case2_improved.m')

% Il programma calcola automaticamente:
% - Distribuzione campo 2D
% - Valori ai 4 piani dell'edificio vicino
% - Profilo ottimizzato al piano critico
% - Decisione conformità

% Output: console + figura + case2_output.png
```

**Tempo esecuzione**: ~5 secondi

---

## 📚 Riferimenti Tecnici

- **DPCM 8 luglio 2003** - Limiti RF Italia
- **CEI EN 50383** - "Metodi di calcolo base per la valutazione dell'esposizione umana ai campi elettromagnetici da stazioni radio base"
- **ICNIRP 2020** - "Guidelines for limiting exposure to electromagnetic fields (100 kHz to 300 GHz)"
- **3GPP TS 36.104** - Specifiche tecniche stazioni base LTE

---

## 💬 Comunicazione con i Cittadini

### Domande Frequenti (e Risposte)

**Q: "Le antenne 5G sono pericolose?"**  
A: I limiti italiani (6 V/m) sono 10 volte più restrittivi di quelli europei e garantiscono ampia sicurezza. Tecnologia 5G usa stessi principi onde radio di 4G/WiFi.

**Q: "Perché mettere l'antenna qui?"**  
A: Copertura ottimale utenti zona. Edifici alti sono ideali per minimizzare esposizione (campo va verso il basso).

**Q: "Quanto campo arriva a casa mia?"**  
A: I calcoli mostrano [X] V/m al vostro piano, ben sotto il limite di 6 V/m. Misure dopo installazione confermeranno.

**Q: "Posso far verificare da esperti indipendenti?"**  
A: Sì, ARPA effettua controlli imparziali. Potete richiedere misure strumentali.

**Q: "Ci sono effetti sulla salute a lungo termine?"**  
A: Studi scientifici (IARC, WHO, ISS) indicano nessun rischio ai livelli dei limiti italiani. Principio precauzionale applicato.

---

## 📊 Dati Reali di Confronto

### Campi RF Tipici in Ambiente Urbano
- **Stazione radio FM**: 1-3 V/m
- **Trasmettitore TV**: 0.5-2 V/m
- **BTS telefonia a 50m**: 0.5-3 V/m (questo caso)
- **WiFi domestico a 1m**: 1-3 V/m
- **Telefono cellulare in chiamata**: 10-40 V/m (vicino testa)

> 💡 Il contributo della BTS è comparabile o inferiore ad altre sorgenti quotidiane

---

## 🔬 Note Tecniche

### Approssimazioni Modello
- Pattern antenna semplificato (gaussiano)
- Riflessioni edifici trascurate
- Potenza costante (no adattamento traffico)
- Singolo settore (installazioni reali: 3 settori)

### Accuratezza
- Errore tipico: ±20-30% rispetto a misure
- Sovrastima conservativa per sicurezza
- Validazioni ARPA su migliaia di siti confermano affidabilità

---

## 👨‍💻 Autore

**Federico Sabbadini**  
EMF Field Analyzer v2.0  
Caso d'uso validato con dati ARPA reali

---

## 🎓 Per Approfondire

- **ISS - Istituto Superiore Sanità**: Rapporti campi elettromagnetici
- **ARPA**: Catasti regionali impianti RF
- **Ministero Salute**: Sezione campi elettromagnetici
- **WHO**: Electromagnetic fields and public health
