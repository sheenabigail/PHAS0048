Lifetime Calculation and Photodissociation Cross Sections
=====
*Source code developed by Dr Marco Pezzella of the ExoMol group*

Modifiable Batch Execution Files
---------
The energy differences at the discontinuities in a stabilization graph were used to calculate lifetime values. To study the effects of varying curve values and parameters (box size and crossing points) on the lifetime value produced several models (Duo inputs) were constructed:

1. `ExoMol\_95Ma\_Shift01ReOr <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift01reor.csh>`_
2. `ExoMol\_95Ma\_Shift08BrHaHo <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift08brhaho.csh>`_
3. `ExoMol\_95Ma\_Unshifted <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_spinorcomp.csh>`_
4. `ExoMol\_ExoMol\_Shift95Ma <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_v2.csh>`_
5. `ExoMol\_ExoMol\_Shift95Ma <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_95ma_v2.csh>`_
6. `19GoYuTe\_19GoYuTe\_Unshifted <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_Duo-intensity_goyute.csh>`_

Where these models were named using the convention of [Source of PEC]\_[Source of SOC]\_[Source of Shift]. For models 1-5, The use of 95Ma as a source for the SOC was only exclusive to the (4Sigma_{1/2}-,2Sigma_{1/2}+) coupling, all other spin-orbit coupling values were obtained using the MRCI method by the ExoMol group.

**Model number 5 uses a grid that extends from 0.85 - 13.82 Å, while models 1-4 used grid sizes of 0.85 - 6.48 Å**

^^^^^^^^^
Each of these Duo input files are modifiable as they are used in the following bash script to automate the process of Duo and ExoCross calculations for a range of box sizes.

.. literalinclude:: ../../supp_code/batch_exec/do-submit-duo-loop.sh
   :language: bash

*L* is the upper box limit, *dl* is the increment between box sizes, *N* is the number of *dl* spaced points that want to be generated, *Jmax* is the total angular momentum number that we are investigating, *T* is the temperature in Kelvin at which the spectra is being simulated for.

^^^^^^^^^
The `h_SH_abs_exocross <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_abs_exocross.sh>`_ file is a modifiable exocross input file to produce the cross sections. 

.. literalinclude:: ../../supp_code/batch_exec/h_SH_abs_exocross.sh
   :language: bash
   
   
The `h_SH_lf_exocross <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH_lf_exocross.sh>`_ is a modifiable exocross input file to calculate the lifetimes (doesn't take coupling into account)

.. literalinclude:: ../../supp_code/batch_exec/h_SH_lf_exocross.sh
   :language: bash
The *fname* and *xcross* needs to be changed appropriately. Where *fname* is desired output file name and *xcross* is the file path for the ExoCross executable.

**SH_MRCI ...** are the resulting .states and .trans from Duo.

The temperature dependent cross sections produced using **h_SH_abs_exocross** are then averaged to produce the photodissociation cross sections using `h_SH-bin.sh <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/batch_exec/h-SH-bin.sh>`_.

^^^^^^^^^
The crossing between PECs from the Duo output were plotted and compared to `reference values <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/CrossingPoints.docx>`_. Differences in crossing points could be corrected through the ADJUST command. Where the energy difference at the current crossing point to the appropriate crossing point was used, an example where the energy difference was found to be -1439.8955 cm-1 is:

.. literalinclude:: ../../supp_code/batch_exec/h-SH_Duo-intensity_95ma_shift01reor.csh
   :language: bash
   :linenos:
   :lines: 108-120

Producing Stabilization Graph
---------

To produce the stabilization graph after **do-submit-duo-loop.sh** is done:

1.	Move states file for that particular model into a separate directory, for example

.. code-block:: bash

   mkdir sh_v1_200points # creates directory
   mv SH_MRCI*.states /dirpath # moving all states files into directory created in previous line
   
   For models used in this project, the resulting state files have been compiled in `directories <https://github.com/sheenabigail/PHAS0048/tree/main/supp_code/states%20files>`_ 
   
2. In the directory with the states files, we grep for a specific symmetry

.. literalinclude:: ../../supp_code/bash_plot.sh
   :language: bash
   
   The resulting .states.2 files have been compiled in `directories <https://github.com/sheenabigail/PHAS0048/tree/main/supp_code/r_output>`_
   
3. After copying the directory into a local machine, the `SH_model.R <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/SH_model.R>`_ code is run

 

*The SH_model.R script performs the following steps:*

*1.	Read the temporary states files with the desired symmetry;*

*2.	Create a NxM matrix, with the number of columns equal to the number of states filesa, and the number of rows equal to the length of  the last of the states file (The last file, the one with bigger r_box, has the larger number of states).*

*3.	Initialize the matrix with NaNs. It is useful for getting rid of the extra lines when encountered.*

*4.	Store the data inside the matrix, and then perform its transpose.*

*5.	Save each of the matrix column in a different file. It will show how the state changes with the box size.  Save the files using two columns, the first column being the box size and second the state energy.*

4. Using Origin, import the data using Import Multiple ASCII and plot the state energy vs box size.

Plotting 
---------

The revised PECs and SOCs have been plotted using `Plotting-NOFIT.ipynb <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/plotting_nb/Plotting-NOFIT.ipynb>`_

[An attempt at] Automated lifetime calculation
---------
Instead of calculating the energy differences by eye, an attempt was made to automate the process. By grepping a certain symmetry for the A2Sigma+ from the .states files, and using the following function

.. code-block:: python
   :linenos:
   :emphasize-lines: 3,5

   def lifetime_calculator(fname):
       # reads file containing grep for a certain state and symmetry
       df = pd.read_csv(fname)
       # making a dictionary to contain the states file
       states_vals = dict(df.values)
       # taking the energy values
       evals = np.array(list(states_vals.values()))
       # counting the no of local minima
       locmin = len(evals[argrelextrema(evals, np.less)[0]])
       # counting the no of local maxima
       locmax = len(evals[argrelextrema(evals, np.greater)[0]])
       # if the number of local minima = local maxima then calculations can proceed
       if locmin==locmax:
           print("Continue")
           E2= evals[argrelextrema(evals, np.greater)[0]]
           E1= evals[argrelextrema(evals, np.less)[0]]
           newdf = pd.DataFrame({'E1' : E1})
           keyval_E1= []
           for i in E1:
               E1key = list(states_vals.keys())[list(states_vals.values()).index(i)]
               keyval_E1.append(E1key)
           keyval_E2= []
           for i in E2:
               E2key = list(states_vals.keys())[list(states_vals.values()).index(i)]
               keyval_E2.append(E2key)
           newdf['E2']=pd.Series(E2)
           newdf['R1']=pd.Series(keyval_E1)
           newdf['R2']=pd.Series(keyval_E2)
           newdf['lifetimes'] = 0.000000000005308838/(0.5*(newdf['E2']-newdf['E1']))
           print("############INITIAL DATAFRAME############")
           print(newdf)
           print("Lifetime Average:",newdf['lifetimes'].mean(),"s")
           print("Lifetime standard deviation",newdf['lifetimes'].std(),"s")
           if (newdf[newdf["lifetimes"]>=1e-11].empty) & (newdf[newdf["lifetimes"]<=1e-13].empty): 
               print("Lifetimes are within picosecond range")
           else:
               dropdf = newdf[(newdf["lifetimes"] < 1e-11) & (newdf["lifetimes"] > 1e-13)]
               print("############AFTER DROPPING############")
               print(dropdf)
               print("Lifetime Average:",dropdf['lifetimes'].mean(),"s")
               print("Lifetime standard deviation",dropdf['lifetimes'].std(),"s")
       # if they are not equal, this implies number of local minima/local maxima detected incorrectly, 
       # so the differences in energies and hence the lifetimes need to be calculated manually.
       else:
           print("Do calculations manually")
           print(f"Detected number of local minima:{locmin}")
           print(f"Detected number of local maxima:{locmax}")
   
The average lifetime values obtained using this method are in agreement with those obtained from manual calculation.
