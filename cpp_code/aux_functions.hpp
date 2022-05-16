// ######################################################################################

// # Copyright 2022, Nicolau Andrés-Thió

// # Permission is hereby granted, free of charge, to any person obtaining a copy
// # of this software and associated documentation files (the "Software"), to deal
// # in the Software without restriction, including without limitation the rights
// # to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// # copies of the Software, and to permit persons to whom the Software is
// # furnished to do so, subject to the following conditions:

// # The above copyright notice and this permission notice shall be included in all
// # copies or substantial portions of the Software.

// # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// # AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// # LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// # SOFTWARE.

// ######################################################################################

#ifndef AUX_FUNCTIONS_HPP
#define AUX_FUNCTIONS_HPP

#include "libraries.hpp"
#include "sample_generator.hpp"
#include "functions.hpp"

// Auxiliary functions to be used by different methods troughout the project.

// Returns the Euclidean distance between two points
double dist(VectorXd &point1, VectorXd &point2);

// Weighted correlation of two datasets given a set of weights. For more information, consult
// Andres-Thio N, Munoz MA, Smith-Miles K (2022): "Bi-fidelity Surrogate Modelling: Showcasing the need for new test instances"
double weightedCorrelationCoefficient(vector<double> &dataSet1, vector<double> &dataSet2, vector<double> &weights);

// Relative Root Mean Squared Error (RRMSE) used to calculate accuracy of trained surrogate model,
// as well as as a feature of a bi-fidelity source. For more information, consult
// Andres-Thio N, Munoz MA, Smith-Miles K (2022): "Bi-fidelity Surrogate Modelling: Showcasing the need for new test instances"
double relativeRootMeanSquaredError(vector<double> &dataSet1, vector<double> &dataSet2);

// Calculates the Correlation Coefficient (CC), Relative Root Mean Squared Error (RRMSE) and Local Correlation Coefficients (LCC) of a bi-fidelity source.
// Does so by taking a sample of size sampleSizeMult * d, where d is the dimension of the bi-fidelity source. For more information, consult
// Andres-Thio N, Munoz MA, Smith-Miles K (2022): "Bi-fidelity Surrogate Modelling: Showcasing the need for new test instances"
vector<double> calculateFunctionFeatures(BiFidelityFunction* function, int sampleSizeMult, int seed, double r = 0.2, vector<double> pVals = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.975});

// For a bi-fidelity source, this function calculates LCC^r_p, LCC^r_sd and LCC^r_coeff for given r and a set of p values.
// Does so by taking a sample of size sampleSizeMult * d, where d is the dimension of the bi-fidelity source, and calculating 
// the weighted correlation at each of those points. For more information, consult
// Andres-Thio N, Munoz MA, Smith-Miles K (2022): "Bi-fidelity Surrogate Modelling: Showcasing the need for new test instances"
vector<double> calculateLocalCorrelations(BiFidelityFunction* function, int sampleSizeMult, int seed, double r, vector<double> pVals);

// Useful function for debugging, takes care of printing point using the right formatting.
void printPoint(VectorXd point);


#endif