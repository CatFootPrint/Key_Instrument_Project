# Key_Instrument_Project
This program is used to identify the signals transmittd from E4438C and received by Black Bird.

The detail discription of programs are as follows.

1. figure_of_data.m is the program to eliminate the frequency offset of received signals.
2. fo_recover.m is the function to eliminate the frequency offset and figure_of_data.m adopts fo_cover.m to recover signals.
3. main.m is the program which adopts the proximal gradient decent method to update the dictionary and update the dictionary set.
4. main_iteration.m is the program which update the dictionary set through proximal gradient descent method and update for many iterations.
5. SDLC_proximal.m is the function of proximal gradient descent method.
6. SDLC_proximal_advanced.m is the function for fast proximal gradient descent method.
7. Signals_measurement.m is the program generating and identifying signals for E4438C to transmit.
8. Signal_simulation.m is the program generateing and identifying signals for simulation.
9. syn.m is the function for generating the m sequence.
10. spectral_cluster.m is the function for spectral clustering proposed by Andrew Ng.
11. my_spectral_cluster.m is the function for spectral clustering proposed by myself.

There are five files here.

1. 1102 stores the data received in Nov. 2nd and these signals are sent with M sequence.
2. data stores the data received. The transmitter is E4438C and the receiver is Black Bird.
3. Result stores the data recovered through the frequency offset eliminating function.
4. STING_result stores the data recover through the STING method.
5. SDLC_result stores the result of proximal gradient descent based result.
