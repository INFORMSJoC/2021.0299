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

#ifndef AUX_SOLVERS_HPP
#define AUX_SOLVERS_HPP

#include "libraries.hpp"
#include "aux_functions.hpp"
#include "functions.hpp"
#include "sample_generator.hpp"


// Implementation of Accelerated Random Search (ARS), a black box solver used for the auxiliary optimisation problems
// when constructing surrogate models. For details, consult
// Appel MJ, Labarre R and Radulovic D (2004): "On accelerated random search"
class ARSsolver{
	public:

	ARSsolver(Function* function, bool min = true, int randomSeed = 0, bool printInfo = false);

	ARSsolver(Function* function, int numSphere, int maxIter, bool min = true, int randomSeed = 0, bool printInfo = false);

	virtual ~ARSsolver();

	// Update the problem which ARS will be run on.
	void updateProblem(Function* function, bool min = true);

	// Reseed the random generator.
	void reseedRandom(int newSeed);

	// Main method which finds best possible point given budget; returns best point found.
	virtual VectorXd optimise();

	// Returns a point within a hypersphere of dimension d and radius 1.
	VectorXd dBallRandomSample(int d);

	Function* function_;					// The function which ARS will optimise.
	SampleGenerator* sampleGenerator_;		// Random generator which creates initial points inside sample space
	bool min_;								// Whether this is an optimisation or a maximisation problem
	int multiplier_;						// Used when problem is a maximisation problem; multiply function output by -1 and minimise instead
	int randomSeed_;						// Random seed used for reproducibility
	mt19937 randomGenerator_;				// Random number generator
	bool printInfo_;						// Whether to print the information as the optimisation is running
	int numSearch_;							// Number of spheres employed by the search
	int maxIter_;							// Number of iterations for each sphere during the optimisation process

	string prePrint_;						// Used to add a message to the print statement when printInfo_ = true

};


#endif