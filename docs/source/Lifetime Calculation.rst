Lifetime Calculation and Photodissociation Cross Sections
=====

The energy differences at the discontinuities in a stabilization graph were used to calculate lifetime values. To study the effects of varying curve values and parameters (box size and crossing points) on the lifetime value produced several models (Duo inputs) were constructed:

1. `ExoMol\_95Ma\_Shift01ReOr <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift01reor.csh>`_
2. `ExoMol\_95Ma\_Shift08BrHaHo <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift08brhaho.csh>`_
3. `ExoMol\_95Ma\_Unshifted <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_spinorcomp.csh>`_
4. `ExoMol\_ExoMol\_Shift95Ma <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_v2.csh>`_
5. `ExoMol\_ExoMol\_Shift95Ma* <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_v2.csh>`_
6. `19GoYuTe\_19GoYuTe\_Unshifted <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_goyute.csh>`_

Where these models were named using the convention of [Source of PEC]\_[Source of SOC]\_[Source of Shift]. For models 1-5, The use of 95Ma as a source for the SOC was only exclusive to the (4Sigma_{1/2}-,2Sigma_{1/2}+) coupling, all other spin-orbit coupling values were obtained using the MRCI method by the ExoMol group.

*Using grid that extends from 0.85 - 13.82 Å, while models 1-4 used grid sizes of 0.85 - 6.48Å

Each of these Duo input files are modifiable as they are used in the following bash script, to automate the process of Duo and ExoCross calculations for a range of box sizes.

.. literalinclude:: ../../supp_code/batch_exec/do-submit-duo-loop.sh
   :language: bash


*L* is the upper box limit, *dl* is the increment between box sizes, *N* is the number of *dl* spaced points that want to be generated, *Jmax* is the total angular momentum number that we are investigating, *T* is the temperature in Kelvin at which the spectra is being simulated for.



The crossing between PECs from the Duo output were plotted and compared to reference values. Differences in crossing points could be corrected through the ADJUST command. Where the energy difference at the current crossing point to the appropriate crossing point was used, an example where the energy difference was found to be -1439.8955 cm-1 is:

.. literalinclude:: ../../supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift01reor.csh
   :language: bash
   :linenos:
   :lines: 108-120

