# NUnitUtilities

A collection of helpful NUnit addins/utilities

## SamplingDecorator

NUnit Test decorator which samples the tests so that only a percentage of the actual tests are executed.

### Installation
  * Copy NUnitUtilities.SamplingDecorator.dll into the addins directory under your nunit installation executable folder.  See http://nunit.org/index.php?p=documentation for more information on your NUnit version.
  
### Usage
  * SamplingDecorator is enabled/controlled via the environment variable nunitutilities_percentagetoexclude.  Setting nunitutilities_percentagetoexclude to a value between 1 and 100 will result in test cases being excluded at that value.  Note that the percentage to exclude is applied to each test case individually (it isn't a true sample...).
  
### Nuget

nuget package page:  https://nuget.org/packages/NUnitUtilities.SamplingDecorator/

install via package manager:  Install-Package NUnitUtilities.SamplingDecorator

# License

NUnitUtilities is licensed under the MIT License

    The MIT License (MIT)

    Copyright (c) 2014 Andy Sipe

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
