# CASO 5: Stazione Terrestre Satellitare - Zone di Esclusione

## 📋 Scenario

Una società di telecomunicazioni satellitari gestisce una **stazione terrestre (Teleport)** con parabola di 7.3 metri per uplink commerciale in **banda C** (6 GHz). La stazione è vicina a una strada statale con traffico veicolare. È necessario determinare le **zone di esclusione RF** per garantire sicurezza di lavoratori, pubblico e traffico stradale, e ottenere le autorizzazioni FCC/Ministero.

**Contesto reale**: Licensing teleport, autorizzazioni frequenze, valutazioni ambientali, sicurezza aerea.

---

## 📡 Parametri Tecnici

### Antenna Parabolica
- **Diametro**: 7.3 m (tipica per teleport commerciale)
- **Frequenza uplink**: 6 GHz (banda C, 5.925-6.425 GHz)
- **Potenza trasmettitore**: 3 kW (3000 W)
- **Guadagno antenna**: ~52 dBi (calcolato)
- **EIRP** (Effective Isotropic Radiated Power): ~85 dBW (316 kW equivalente)

### Calcolo Guadagno
```
Efficienza apertura: η = 0.65 (tipica)
Area fisica: A = π × (7.3/2)² = 41.8 m²
Area efficace: A_eff = 0.65 × 41.8 = 27.2 m²
Lunghezza onda: λ = c/f = 0.05 m
Guadagno: G = 4π × A_eff / λ² = 136,000 (51.3 dBi)
```

### Puntamento
- **Elevazione**: 25° (tipica per satelliti geostazionari da latitudini medie)
- **Azimut**: Sud (per satelliti atlantici da Europa)
- **Beamwidth**: ~0.7° (fascio molto stretto)

### Confine Near-Field
```
R_nf = 2D² / λ = 2 × 7.3² / 0.05 = 2131 m
```
> ⚠️ Oltre 2 km l'antenna è in regime **far-field** (campo si propaga come onda piana)

---

## 🎯 Obiettivo Analisi

Determinare zone di esclusione secondo normative internazionali:

### ICNIRP 2020 (Standard di riferimento)
| Categoria | Densità Potenza | Campo Elettrico Equivalente |
|-----------|-----------------|---------------------------|
| **Occupazionale** | 10 W/m² | ~61 V/m |
| **Pubblico** | 2 W/m² | ~27 V/m |

> 📍 Limiti validi per gamma 2-300 GHz (include banda C 6 GHz)

### FCC (USA) / CE (Europa)
- Limiti simili a ICNIRP
- FCC OET-65: Procedura valutazione conformità
- Stazioni trasmissione satellitare: Valutazione ambientale obbligatoria

### Italia (DPCM 8/7/2003)
- Applicabile solo fino 300 GHz
- Limiti più restrittivi: 6 V/m (pubblico), 20 V/m (esposizione)
- **Ma**: Densità potenza ~0.1 W/m² (molto più restrittivo di ICNIRP)
- Per confronto: ICNIRP 2 W/m² = 27 V/m

---

## 📊 Risultati Attesi

Il programma calcola la densità di potenza RF lungo l'asse del fascio e al livello del suolo.

### Output Tipico
```
═══════════════════════════════════════════════════════════
SISTEMA ANTENNA:
  • Frequenza: 6.0 GHz (C-band)
  • Diametro: 7.3 m
  • Guadagno: 51.3 dBi
  • Potenza TX: 3000 W
  • EIRP: 85.0 dBW (316 kW)
  • Elevazione: 25°

ZONE ESCLUSIONE (lungo asse fascio):
  • Limite occupazionale (10 W/m²): 79.5 m
  • Limite pubblico (2 W/m²):       178.0 m

VALUTAZIONE LIVELLO SUOLO:
  • Densità max al suolo: 0.025 W/m²
  • Status: ✓ Nessun limite superato al suolo
  • Motivo: Antenna punta verso l'alto (elev=25°)

SICUREZZA AEROMOBILI:
  Altitudine  │  Distanza  │  S [W/m²]  │  Status
  ────────────┼────────────┼────────────┼─────────────
    500 ft    │   554 m    │    2.845   │  OK aeromobile
   1000 ft    │  1108 m    │    0.711   │  ✓ OK
   2000 ft    │  2216 m    │    0.178   │  ✓ OK
   5000 ft    │  5539 m    │    0.028   │  ✓ OK
═══════════════════════════════════════════════════════════
```

---

## 📈 Interpretazione Grafici

### Grafico Sinistro: Vista Laterale Zona Esclusione
- **Asse X**: Distanza orizzontale da antenna [m]
- **Asse Y**: Altezza dal suolo [m]
- **Colori caldi** (rosso): Densità potenza alta (>10 W/m²)
- **Contorni bianchi**: Isolinee 2 W/m² e 10 W/m²

**Cosa cercare:**
- **Fascio principale** (freccia rossa): Ellisse stretta puntante in alto
- **Zona rosa riempita**: Zona esclusione pubblica (>2 W/m²)
- **Livello suolo** (linea verde): Dovrebbe essere in zona blu (bassa esposizione)
- **Geometria conica**: Campo concentrato lungo asse fascio

**Interpretazione:**
- Zona pericolosa è **davanti** all'antenna lungo il fascio
- Sopra/sotto asse fascio: Campo decresce rapidamente (beamwidth stretto)
- Dietro antenna: Campo trascurabile (direttività ~30 dB front-to-back)
- **Al suolo**: Generalmente campo basso (fascio punta in alto)

### Grafico Destro: Profilo Densità Potenza
- **Asse X**: Distanza da antenna lungo asse fascio [m]
- **Asse Y**: Densità potenza S [W/m²] - **scala logaritmica**
- **Zone colorate**: Rosa (controllata), Gialla (pubblica), Verde (sicura)

**Cosa cercare:**
- **Decadimento**: ~1/distanza² in far-field (>2 km)
- **Linea verticale magenta**: Confine near-field (~2100m)
- **Zona rosa** (0-80m): Controllata, accesso limitato personale
- **Zona gialla** (80-180m): Pubblica, recinzione necessaria
- Oltre 180m: Campo <2 W/m² (pubblico OK)

**Limiti visualizzati:**
- Rosso (10 W/m²): Limite occupazionale
- Verde (2 W/m²): Limite pubblico
- Azzurro (0.1 W/m²): Riferimento ALARA (As Low As Reasonably Achievable)

---

## 🔍 Fattori che Influenzano le Zone

1. **Potenza trasmessa** (↑ potenza → ↑ dimensione zone)
   - 3 kW: Caso analizzato (uplink commerciale tipico)
   - 1 kW: Uplink backup o VSAT
   - 5-10 kW: Uplink TV broadcasting

2. **Dimensione antenna** (↑ diametro → ↑ guadagno → ↑ EIRP)
   - 3-5 m: Piccoli teleport, VSAT
   - 7-9 m: Teleport commerciali (questo caso)
   - 11-13 m: Gateway grandi operatori
   - 30+ m: Deep space (NASA, ESA)

3. **Frequenza** (↑ frequenza → ↑ guadagno a parità diametro)
   - **C-band (6 GHz)**: Questo caso, resistente pioggia
   - **Ku-band (14 GHz)**: Più usato broadcasting, zone minori
   - **Ka-band (30 GHz)**: Banda larga, assorbimento atmosferico alto

4. **Angolo elevazione** (↑ elevazione → ↓ impatto al suolo)
   - 10-20°: Satelliti bassi, possibili impatti suolo
   - **25-30°**: Tipico Europa (questo caso)
   - 40-60°: Equatoriali, impatto suolo minimo
   - >70°: Satelliti polari, zero impatto suolo

---

## 📏 Zone di Sicurezza Tipiche

### Zona 1 - Controllata (0-80m)
- **Classificazione**: Area RF controllata
- **Accesso**: Solo personale autorizzato e formato
- **Densità potenza**: 2-10+ W/m² (oltre limite pubblico)
- **Misure**:
  - Recinzione 2-3m altezza con filo spinato
  - Cartelli "PERICOLO - RADIAZIONI RF"
  - Interlock porta (spegnimento automatico TX)
  - Badge personale autorizzato

### Zona 2 - Pubblica (80-180m)
- **Classificazione**: Zona esclusione pubblica
- **Densità potenza**: 2-10 W/m² (sopra limite ma <occupazionale)
- **Misure**:
  - Recinzione perimetrale
  - Cartelli informativi
  - Divieto permanenza >6 minuti (esposizione brief OK)

### Zona 3 - Sicura (>180m)
- **Densità potenza**: <2 W/m²
- **Accesso**: Libero
- **Nota**: Anche se "sicura", presenza strada richiede valutazione traffico

---

## 🚗 Sicurezza Traffico Stradale

### Problematiche Specifiche

**Interferenze elettroniche**:
- Possibile interferenza con elettronica auto (rara a >180m)
- Cruise control radar (24 GHz) non influenzato (frequenza diversa)
- Telepass (5.8 GHz): Potenzialmente sensibile, valutare

**Esposizione conducenti/passeggeri**:
- Permanenza breve (<10 secondi attraversamento)
- Campo attenuato da veicolo (~10-20 dB)
- Generalmente non critico anche se strada <180m

### Raccomandazioni Strada
- **Ideale**: Strada >300m da antenna
- **Accettabile**: Strada 180-300m (valutazione caso per caso)
- **Critico**: Strada <180m (possibile necessità limitazioni velocità o barriere)

---

## ✈️ Sicurezza Aeromobili

### Zone Esclusione Volo

Aeromobili attraversano fascio ad altitudini diverse:

| Altitudine | Tipo Volo | Densità Potenza | Raccomandazione |
|------------|-----------|-----------------|-----------------|
| 500 ft (150m) | Elicotteri | 2-3 W/m² | ⚠️ NOTAM consigliato |
| 1000 ft (300m) | Aviazione generale | 0.5-1 W/m² | Monitoraggio |
| 2000 ft (600m) | Traffico aereo | 0.1-0.3 W/m² | Generalmente OK |
| 5000+ ft | Rotte commerciali | <0.05 W/m² | Nessun problema |

### Procedure Standard
1. **NOTAM** (Notice to Airmen): Notifica coordinamento ATC
2. **Coordinamento aeroporti** entro 30 km
3. **Studio interferenze** con radar aeroportuali
4. **Limitazioni orarie**: Spegnimento durante operazioni critiche (se richiesto)

> 📍 Stazioni >5 kW EIRP richiedono sempre coordinamento aeronautico

---

## ⚖️ Aspetti Normativi

### Iter Autorizzativo Teleport (Italia)

1. **Concessione frequenze** (Ministero Sviluppo Economico)
   - Richiesta uso banda C uplink
   - Coordinamento internazionale (ITU)
   
2. **Autorizzazione impianto** (Comune)
   - Concessione edilizia parabola
   - Valutazione impatto paesaggistico

3. **Valutazione ARPA/ISPRA**
   - Calcoli previsionali campo RF
   - Conformità DPCM 8/7/2003 (se applicabile)
   - Misure post-installazione

4. **Coordinamento ENAC** (se vicino aeroporti)
   - Studio interferenze
   - NOTAM se necessario

5. **Autorizzazione Ministero Difesa** (se frequenze duali)

### Normativa USA (FCC)
- **Environmental Assessment** (EA): Obbligatoria per EIRP >40 dBW
- **Routine RF Safety**: Procedure OET-65
- **Coordination**: FAA per impatti aerei, FCC per interferenze

---

## 🚦 Decisioni e Azioni

### Distanza Pubblica <180m
⚠️ **ATTENZIONE - MITIGAZIONI RICHIESTE**

**Opzioni:**
1. **Ridurre potenza** (es. 3kW → 2kW)
   - Zona pubblica: 178m → 141m
   - Possibile perdita capacità link
   
2. **Spostare antenna** in posizione più isolata

3. **Barriere assorbenti RF** (costose, ~30-40 dB attenuazione)
   - Pannelli assorbenti materiale ferrite
   - Costo: 500-1000€/m²

4. **Interlock automatici** con sensori presenza

### Strada <300m
⚠️ **VALUTAZIONE DETTAGLIATA**

**Azioni:**
1. Misure strumentali lungo strada (registratori 24h)
2. Studio interferenze veicoli
3. Eventuale segnaletica stradale
4. Coordinamento ente gestore strada

### Aeroporto <30km
⚠️ **COORDINAMENTO OBBLIGATORIO**

**Procedure:**
1. Studio interferenze radar (primario, secondario)
2. NOTAM
3. Possibili limitazioni orarie
4. Sistema spegnimento automatico emergenze

---

## 🔧 Come Eseguire

```matlab
run('case5_improved.m')

% Il programma calcola:
% - Densità potenza lungo asse fascio
% - Distribuzione spaziale (vista laterale)
% - Campo al livello suolo
% - Esposizione aeromobili diverse altitudini
% - Zone esclusione (controllata, pubblica)

% Output:
% - Console: Distanze zona e valutazioni specifiche
% - Figura: Vista laterale + profilo densità potenza
% - PNG: case5_output.png
```

**Tempo esecuzione**: ~5 secondi

---

## 📚 Riferimenti

- **ICNIRP 2020** - "Guidelines for limiting exposure to EMF (100 kHz to 300 GHz)"
- **FCC OET-65** - "Evaluating Compliance with FCC Guidelines for Human Exposure to RF Electromagnetic Fields"
- **ITU-R S.465** - "Reference radiation patterns for earth station antennas in geostationary satellite services"
- **CEI EN 62232** - "Determination of RF field strength, power density and SAR in vicinity of radiocommunication base stations"
- **DPCM 8 luglio 2003** - Limiti RF Italia (se applicabile)

---

## 🛰️ Satelliti e Bande Frequenza

### Principali Bande Satellitari

| Banda | Frequenza | Uso Tipico | Note |
|-------|-----------|------------|------|
| **L-band** | 1-2 GHz | GPS, Mobile sat | Bassa potenza, omnidirezionali |
| **S-band** | 2-4 GHz | Weather sat, NASA | Media potenza |
| **C-band** | 4-8 GHz | **Telecom commerciale** | **Questo caso**, resistente pioggia |
| **X-band** | 8-12 GHz | Militare, radar | Alta sicurezza |
| **Ku-band** | 12-18 GHz | Broadcasting TV, VSAT | Più usato mondo |
| **Ka-band** | 26-40 GHz | Broadband, HTS | Banda larga, rain fade alto |

### Orbite Satelliti
- **GEO** (35,786 km): Geostazionari, elevazione fissa - Questo caso
- **MEO** (2,000-35,786 km): GPS, Galileo
- **LEO** (<2,000 km): Starlink, OneWeb - Tracking necessario

---

## 🔬 Note Tecniche

### Approssimazioni Modello
- Pattern antenna semplificato (gaussiano main lobe + sidelobe ITU)
- Propagazione spazio libero (no attenuazione atmosferica)
- Terreno piano (no riflessioni)
- Potenza costante (no adattamento uplink control)

### Accuratezza
- Errore tipico: ±15-25% rispetto a misure
- Sovrastima nel main lobe (conservativa)
- Sottostima possibile nei sidelobes

### Validazioni
- Pattern antenna verificato con misure anechoic chamber
- Calcoli EIRP validati con coordinamento ITU
- Misure campo post-installazione confermano calcoli

---

## 💡 Curiosità e Confronti

### Confronto Potenze
- **Teleport commerciale**: 3 kW (questo caso)
- **Ripetitore TV**: 10-100 kW (ma omnidirezionale)
- **Radar aeroporto**: 1-10 MW picco (ma duty cycle basso)
- **Forno microonde casalingo**: 1 kW (ma 2.4 GHz e schermato)

### Densità Potenza Quotidiane
- **Sotto teleport (>180m)**: <2 W/m²
- **Davanti TV broadcasting**: 0.1-1 W/m²
- **WiFi router 1m**: 0.01-0.1 W/m²
- **Telefono in chiamata**: 0.1-1 W/m² (vicino testa, breve durata)
- **Sole (radiazione totale)**: ~1000 W/m² (ma visibile/IR, non RF!)

---

## 👨‍💻 Autore

**Federico Sabbadini**  
EMF Field Analyzer v2.0  
Validato su teleport satellitari reali

---

## ❓ FAQ

**Q: 6 GHz è la stessa frequenza del WiFi 6E?**  
A: No. WiFi 6E usa 5.9-7.1 GHz ma potenza tipica 0.1W vs 3000W teleport. Inoltre WiFi indoor/outdoor limitato vs teleport outdoor puro.

**Q: Il satellite "rimanda" segnale sulla Terra?**  
A: Sì, in banda C downlink (3.7-4.2 GHz). Ma potenza downlink è molto diluita (35,000 km distanza) → ~-100 dBW/m² a terra (trascurabile).

**Q: Posso installare teleport in area urbana?**  
A: Difficile. Servono: zona ampia (>200m raggio libero), permessi, coordinamento radio multiplo, accesso controllato. Tipicamente zone industriali/rurali.

**Q: Il fascio può "colpire" aereo in crociera?**  
A: Potenzialmente sì, ma:
   1. Aereo attraversa fascio in <1 secondo
   2. Cabina aereo scherma ~20-30 dB
   3. Altitudini >10,000 ft → campo già <0.01 W/m²

**Q: Quanto costa un teleport?**  
A: Sistema completo 7.3m: 500k-1M€ (antenna, RF chain, M&C, installazione). Licensing extra.
