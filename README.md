# ECG Signal Analysis Tool with GUI

This project is a **MATLAB-based application** for analyzing and processing ECG (Electrocardiogram) signals.  
It was developed as part of a university course project and later refined for accuracy and usability.

---

## Features

- **Signal Preprocessing**  
  - Removal of baseline drift and high-frequency noise using high-pass and low-pass filters.  
  - Improved frequency domain handling using `fftshift`.  

- **Feature Extraction**  
  - R-peak detection  
  - RR interval calculation  
  - Heart Rate Variability (HRV) analysis (time and frequency domain)  

- **Stochastic Modeling**  
  - Generation of synthetic heart rate time series using an Autoregressive (AR) model.  
  - Adjustable mean and standard deviation for custom simulations.  

- **Visualization Tools**  
  - Time-domain ECG signals with peaks  
  - Frequency-domain spectra  
  - RR interval plots and power spectrum  
  - Comparison between real and synthetic heart rate signals  

- **User-Friendly GUI**  
  - Built using MATLAB App Designer (`.mlapp`)  
  - Dropdown menus for signal selection  
  - Interactive buttons for processing and heart rate synthesis  

---

## Lessons Learned

At the time of the project, the concept of `fftshift` (for centering the Fourier transform spectrum) was not applied.  
This caused the frequency-domain plots to appear off-centered.  

Later, the code was **fixed to include `fftshift`**, ensuring that the frequency analysis is properly aligned and visually correct.  
This adjustment improved both the accuracy and clarity of the results.

---

## File Structure

- `Prob_GUI.mlapp` → The MATLAB App Designer GUI file  
- `Project_Report.pdf` → Full project report with design, testing, and results  
- Supporting MATLAB scripts (FFT, filtering, stochastic modeling, visualization)

---

## How to Run

1. Open MATLAB.  
2. Run `Prob_GUI.mlapp` in App Designer.  
3. Use the dropdown menu to select an ECG signal (provided in the input `.xls` files).  
4. Enter cutoff frequencies (e.g., 0.5–0.6 Hz for high-pass, 50–60 Hz for low-pass).  
5. Press **Process** to filter and analyze the signal.  
6. (Optional) Generate synthetic heart rate data using the **Synthesize HR** button.

---


## Acknowledgment

This project was completed as part of **CEN330 – Signals and Systems** coursework under the supervision of Eng. Gasm El Bary.  
Special thanks to my teammates for collaboration and contributions to the design and implementation.

---
