# 📡 EMF Field Analyzer (Elettrosmog)

[![MATLAB](https://img.shields.io/badge/MATLAB-100%25-0076A8.svg)](https://mathworks.com/products/matlab.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Progetto MATLAB per il monitoraggio e l'analisi dell'inquinamento elettromagnetico (elettrosmog).**

## Overview

Elettrosmog è un progetto MATLAB finalizzato al monitoraggio e all'analisi del fenomeno dell'inquinamento elettromagnetico attraverso la raccolta di dati e visualizzazioni.

L'obiettivo è fornire uno strumento utile per comprendere l'impatto dei campi elettromagnetici sull'ambiente e sensibilizzare sui potenziali effetti sulla salute.

## Purpose

L'applicazione utilizza dati elettromagnetici noti o dati da sensori, li organizza e li rende disponibili per analisi dettagliate attraverso dashboard e report.

Può essere utilizzata da:
- Ricercatori
- Agenzie di monitoraggio ambientale
- Appassionati interessati a tracciare la qualità elettromagnetica del proprio ambiente

## Struttura del Progetto

```
emf-field-analyzer/
├── antenne (HF - [10^5-10^11] Hz)/    # Dati alta frequenza (antenne)
├── elettrodotti (eLF - [50]Hz)/        # Dati bassa frequenza (elettrodotti)
└── README.md
```

## Bande di Frequenza Coperte

| Categoria | Range Frequenza | Sorgenti |
|-----------|-----------------|----------|
| ELF (Extremely Low Frequency) | ~50 Hz | Elettrodotti, infrastrutture elettriche |
| HF (High Frequency) | 10⁵ - 10¹¹ Hz | Antenne, trasmettitori radio, torri cellulari |

## Requisiti

- MATLAB (versione consigliata: R2020b o superiore)

## License

MIT License — See [LICENSE](LICENSE) for details.
