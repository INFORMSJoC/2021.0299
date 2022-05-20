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

#ifndef INPUT_OUTPUT_HPP
#define INPUT_OUTPUT_HPP

#include "libraries.hpp"
#include "aux_solvers.hpp"
#include "functions.hpp"
#include "kriging.hpp"

// Functions used to interpret the information passed as input when calling the project.

// Function which takes a function name and outputs the correct bifidelity source function. For more information on the available functions,
// consult the functions.hpp file.
BiFidelityFunction* processFunctionName(string name);

// Need further processing when specifying a COCO function, this function deals with that.
COCOBiFunction* processCOCOFunctionName(string name);

// Function which takes in an experiment specification as a string and processes the information. It then calls executeExperiment to run the specifications.
// r and pVals are specifications used when calculating the LCC feature. 
void processExperiment(string outputFilename, string instructionLine, double r, vector<double> pVals);

// Executes the experiment as speficied by "processExperiment". 
double executeExperiment(string filename, string functionName, string technique, int highFiBudget, int lowFiBudget, int seed, double r, vector<double> pVals,
							bool printSolverInfo = true, bool printAllInfo = false, int testSampleSize = 1000, int auxSolverIterations = 1000);




#endif