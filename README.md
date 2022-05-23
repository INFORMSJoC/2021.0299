[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

# Bi-fidelity Surrogate Modelling: Showcasing the need for new test instances

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the [MIT license](LICENSE).

The software and data in this repository are a snapshot of the software and data
that were used in the research reported on in the paper 
[Bi-fidelity Surrogate Modelling: Showcasing the need for new test instances](https://doi.org/10.1287/ijoc.2019.0934) (UPDATE LINK) by Andrés-Thió N, Muñoz MA, and Smith-Miles K. 
The snapshot is based on v1.1 of the software available in [this repository](https://github.com/nandresthio/Bifidelity-Surrogate-Modelling/releases/tag/v1.1) and the data vailable on [figshare](https://figshare.com/projects/Bifidelity-Surrogate-Modelling_data/132887). 

**Important: This code is being maintained at https://github.com/nandresthio/Bifidelity-Surrogate-Modelling. Please go there if you would like to
get a more recent version or would like support**

## Cite

To cite this software, please cite the [paper](https://doi.org/10.1287/ijoc.2019.0934) (UPDATE LINK) using its DOI and the software itself, using the following DOI. (UPDATE DOI)

[![DOI](https://zenodo.org/badge/285853815.svg)](https://zenodo.org/badge/latestdoi/285853815)

Below is the BibTex for citing this version of the code. (UPDATE DOI)

```
@article{CacheTest,
  author =        {T. Ralphs},
  publisher =     {INFORMS Journal on Computing},
  title =         {{CacheTest} Version v1.0},
  year =          {2020},
  doi =           {10.5281/zenodo.3977566},
  url =           {https://github.com/INFORMSJoC/JoCTemplate},
}  
```

## Description

The code implements Kriging[^1][^2] and Co-Kriging[^3][^4] as surrogate models. That is, the implementation generates a sample of a bi-fidelity function (a high fidelity sample and a low fidelity sample of specified size), and trains the chosen surrogate model, without the added functionality of choosing further samples. Both of these models are described in the appendix given in the `appendix` folder. Multiple literature test instances are implemented here[^6][^7][^8][^9][^10][^11][^12][^13][^14][^15][^16], as well as a novel instance creation procedure which adds a disturbance to a high-fidelity function to create a low-fidelity function. In this implementation functions from the COCO test suite[^17] are used as the high fidelity functions. The performance of both Kriging and Co-Kriging is assessed by calculating the Relative Root Mean Squared Error (RRMSE) between the trained model and the high fidelity source.

## Repository structure

The repository structure is used by the provided software when reading and storing data, results and graphs. It is therefore important the folder structure is not modified. 

The folder `cpp_code` contains all the C++ code which implements Kriging and Co-Kriging, the initial sampling plans, the accelerated random search algorithm for auxiliary optimisation, and the implemented instances, that is the pairs of high and low fidelity functions which are sampled to build a model.

The folder `data` contains the following subfolders. The subfolder `availableFunctions` contains the text files with the names of the instances from the literature, separated by dimension. This is used by the R scripts which generate the runscripts to be run on a cluster. The subfolder `clusterResults` contains the results (i.e. model accuracy results) of running experiments, that is constructing a surrogate model (either Kriging or Co-Kriging) on a particular instance, as well as the features of the instance. The subfolder `plots` contains the created analysis plots when analysing the cluster results. In particular it contains plots of the instances based on their feature values, the statistical analysis of which model performed best, and the constructed prediction trees as well as the plots showcasing features importance. Finally, the subfolder `runScripts` contains the scripts which specify what experiments to run on the cluster.

The folder `R_code` contains all the R scripts used to create the run scripts, as well as the scripts used to analyse and plot the cluster run results.

The folder `scripts` contains bash scripts to be run from terminal, which either run the experiments specified in a run script sequentially, or in a cluster using Slurm.

The folder `appendix` contains a pdf document with the appendix to Bi-fidelity Surrogate Modelling: Showcasing the need for new test instances. In it the mathematical formulations of Kriging and Co-Kriging are given in detail.

## Building

In order to run both the C++ program and the R scripts, the following need to be installed:

  * C++ compiler: gcc is recommended but any compiler should work. If a different compiler is chosen make sure the file `cpp_code/Makefile.local` is eddited accordingly. Installation instructions can be found [here](https://gcc.gnu.org/install/)

  * cmake: Installation instructions can be found [here](https://cmake.org/install/)

  * C++ libraries: The C++ code relies on the following libraries to work; `algorithm`, `cfloat`, `cmath`, `fstream`, `iostream`, `list`, `random`, `string`, `tuple`, `vector` and `Eigen/Dense`. Apart from the the Eigen library (more details below), all other libraries are included in the project by the `cpp_code/libraries.hpp` and should require no special setup by the user.

  * Eigen: Details about this library can be found [here](https://eigen.tuxfamily.org/dox/GettingStarted.html). This library needs to be downloaded, and the path to eigen inside `cpp_code/Makefile.local` needs to be modified to match that of the download location.

  * R: The scripts call R using the terminal command `Rscript`. This needs to be installed on the local machine. On top of R, the following R libraries are required: `stringr`, `ggplot2`, `gridExtra`, `egg`, `rpart`, `tibble` and `bitops`.

Simply running the file `runAllExperiments.bash` from the terminal should build the executable. If you desire to build the C++ executable before running the script however, simply go to the `cpp_folder` and run the command `make local`.

As given, all experiments and analysis can be run sequentially by simply running the script, although this is not recommended. Rather, it is recommmended to use a computer cluster to run the main experiments as indicated in the bash script.

## Results

After completing all experiments and analysis, the folder `data` and its subfolders should contain all of the experimental results and analysis plots as produced by the run. The current `data` folder contains all the results and plots obtained when running the software for the purposes of the study. 


## Replicating

To reproduce the results, follow the instructions given in the `runAllExperiments.bash` file. Note that running the software will override the data folder with new results and figures. Note also that discrepancies are expected between the given data and plots and those created by re running the sofware. This is due to the fact however that the features of the instances created using the COCO suite and disturbances will vary based on the system these experiments are run on, as function instantiation includes randomness. Whilst all random functions are seeded by constants to allow for reproducibility on the same system, the random sequences (and therefore the final functions) generated by different systems might vary.


## Ongoing Development

This code is being developed on an on-going basis at the author's
[Github site](https://github.com/nandresthio/Bifidelity-Surrogate-Modelling).

## Support

For support in using this software, submit an
[issue](https://github.com/nandresthio/Bifidelity-Surrogate-Modelling).



[^1]: Krige DG (1951) "A statistical approach to some basic mine valuation problems on the witwatersrand". Journal of the Southern African Institute of Mining and Metallurgy 52(6):119–139.
[^2]: Jones DR (2001) "A taxonomy of global optimization methods based on response surfaces". Journal of global optimization 21(4):345–383.
[^3]: Kennedy MC, O’Hagan A (2000) "Predicting the output from a complex computer code when fast approximations are available". Biometrika 87(1):1–13.
[^4]: Forrester AI, S ́obester A, Keane AJ (2007) "Multi-fidelity optimization via surrogate modelling". Proceedings of the royal society a: mathematical, physical and engineering sciences 463(2088):3251–3269.
[^5]: Toal DJ (2015) "Some considerations regarding the use of multi-fidelity kriging in the construction of surrogate models". Structural and Multidisciplinary Optimization 51(6):1223–1245.
[^6]: Song X, Lv L, Sun W, Zhang J (2019) "A radial basis function-based multi-fidelity surrogate model: exploring correlation between high-fidelity and low-fidelity models". Structural and Multidisciplinary Optimization 60(3):965–981.
[^7]: March A, Willcox K (2012) "Provably convergent multifidelity optimization algorithm not requiring high-fidelity derivatives". AIAA journal 50(5):1079–1089.
[^8]: Rajnarayan D, Haas A, Kroo I (2008) "A multifidelity gradient-free optimization method and application to aerodynamic design". 12th AIAA/ISSMO multidisciplinary analysis and optimization conference, 6020.
[^9]: Liu B, Koziel S, Zhang Q (2016) "A multi-fidelity surrogate-model-assisted evolutionary algorithm for computationally expensive optimization problems". Journal of computational science 12:28–37.
[^10]: Wang H, Jin Y, Doherty J (2017) "A generic test suite for evolutionary multifidelity optimization". IEEE Transactions on Evolutionary Computation 22(6):836–850.
[^11]: Liu H, Ong YS, Cai J, Wang Y (2018b) "Cope with diverse data structures in multi-fidelity modeling: a gaussian process method". Engineering Applications of Artificial Intelligence 67:211–225.
[^12]: Wu Y, Hu J, Zhou Q, Wang S, Jin P (2020) "An active learning multi-fidelity metamodeling method based on the bootstrap estimator". Aerospace Science and Technology 106:106116.
[^13]: Shi M, Lv L, Sun W, Song X (2020) "A multi-fidelity surrogate model based on support vector regression". Structural and Multidisciplinary Optimization 1–13.
[^14]: Dong H, Song B, Wang P, Huang S (2015) "Multi-fidelity information fusion based on prediction of kriging". Structural and Multidisciplinary Optimization 51(6):1267–1280.
[^15]: Xiong S, Qian PZ, Wu CJ (2013) "Sequential design and analysis of high-accuracy and low-accuracy computer codes". Technometrics 55(1):37–46.
[^16]: Park C, Haftka RT, Kim NH (2018) "Low-fidelity scale factor improves bayesian multi-fidelity prediction by reducing bumpiness of discrepancy function". Structural and Multidisciplinary Optimization 58(2):399–414.
[^17]: Hansen N, Auger A, Ros R, Mersmann O, Tuˇsar T, Brockhoff D (2020) "COCO: A platform for comparing continuous optimizers in a black-box setting". Optimization Methods and Software URL http://dx.doi.org/https://doi.org/10.1080/10556788.2020.1808977