Lifetime Calculation and Photodissociation Cross Sections
=====

The energy differences at the discontinuities in a stabilization graph were used to calculate lifetime values. To study the effects of varying curve values and parameters (box size and crossing points) on the lifetime value produced several models (Duo inputs) were constructed:

1. `ExoMol\_95Ma\_Shift01ReOr <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift01reor.csh>`_
2. `ExoMol\_95Ma\_Shift08BrHaHo <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift08brhaho.csh>`_
3. `ExoMol\_ExoMol\_Shift95Ma <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_v2.csh>`_
4. `ExoMol\_ExoMol\_Shift95Ma* <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_v2.csh>`_
5. `ExoMol\_95Ma\_Unshifted <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_spinorcomp.csh>`_
6. `19GoYuTe\_19GoYuTe\_Unshifted <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_goyute.csh>`_

Where these models were named using the convention of [Source of PEC]\_[Source of SOC]\_[Source of Shift]. For models 1-5, The use of 95Ma as a source for the SOC was only exclusive to the $(^4\Sigma_{1/2}^-,^2\Sigma_{1/2}^+)$ coupling, all other spin-orbit coupling values were obtained using the MRCI method by the ExoMol group.

Each of these Duo input files are modifiable as they are used in the following bash script, to automate the process of Duo and ExoCross calculations for a range of box sizes.

.. literalinclude:: ../../supp_code/batch_exec/do-submit-duo-loop.sh
   :language: bash


