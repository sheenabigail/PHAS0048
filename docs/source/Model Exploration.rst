Model Exploration
=====

Resources that contained experimental and theoretcial lifetimes of the A2Sigma+ state of SH were first compiled into a `folder <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/resources/LITERATURE.zip>`_. The tabular and graphical data for the PEC, SOC, AMC, and DMC of SH were then put together in a `presentation <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/resources/CURVES%20FOR%20DUO.pptx>`_ to be selected. The values of the selected curves were tabulated in an `excel file <https://github.com/sheenabigail/PHAS0048/blob/main/supp_code/curve_lit_data.xlsx>`_.

The tabulated values were then adapted into a Duo input format, an example for the PEC is 

.. literalinclude:: ../../supp_code/pec_files/PEC_08BrHaHo.dat
   :language: python
   
.. _installation:

Installation
------------

To use Lumache, first install it using pip:

.. code-block:: console

   (.venv) $ pip install lumache

Creating recipes
----------------

To retrieve a list of random ingredients,
you can use the ``lumache.get_random_ingredients()`` function:

.. autofunction:: lumache.get_random_ingredients

The ``kind`` parameter should be either ``"meat"``, ``"fish"``,
or ``"veggies"``. Otherwise, :py:func:`lumache.get_random_ingredients`
will raise an exception.

.. autoexception:: lumache.InvalidKindError

For example:

>>> import lumache
>>> lumache.get_random_ingredients()
['shells', 'gorgonzola', 'parsley']

