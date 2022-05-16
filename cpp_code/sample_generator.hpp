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

#ifndef SAMPLE_GENERATOR_HPP
#define SAMPLE_GENERATOR_HPP

#include "libraries.hpp"
#include "aux_functions.hpp"
#include "functions.hpp"

class SampleGenerator{
	public:

	SampleGenerator(Function* function, int randomSeed, bool printInfo = false);

	~SampleGenerator();

	vector<VectorXd> randomLHS(int sampleSize);

	double morrisMitchellCriterion(vector<VectorXd> &pointSet);

	vector<VectorXd> morrisMitchellSubset(vector<VectorXd> &pointSet, int subsetSize);

	void updateProblem(Function* function);


	mt19937 randomGenerator_;
	Function* function_;
	bool printInfo_;

	string prePrint_;

};

#endif