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

