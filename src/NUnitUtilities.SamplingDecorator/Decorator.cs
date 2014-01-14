using System;
using System.Reflection;
using NUnit.Core;
using NUnit.Core.Extensibility;

namespace NUnitUtilities.SamplingDecorator {
  [NUnitAddin(Name = "NUnitUtilities Sampling Decorator", Description = "Test decorator which samples the tests so that only a percentage of the actual tests are executed.")]
  public class Decorator : IAddin, ITestDecorator {
    public bool Install(IExtensionHost host) {
      var decorators = host.GetExtensionPoint("TestDecorators");
      if (decorators == null)
        return false;
      Configure();
      if (mEnabled) {
        decorators.Install(this);
        Console.WriteLine("NUnitUtilities Sampling Decorator Enabled with an exclude percentage of {0}", mPercentageChangeToExclude);
      }
      return mEnabled;
    }

    public Test Decorate(Test test, MemberInfo member) {
      if (_Random.Next(1, 100) < mPercentageChangeToExclude)
        test.RunState = RunState.Explicit;
      return test;
    }

    private void Configure() {
      var val = Environment.GetEnvironmentVariable("nunitutilities_percentagetoexclude");
      if (val == null)
        mEnabled = false;
      else {
        mPercentageChangeToExclude = int.Parse(val);
        mEnabled = (mPercentageChangeToExclude >= 1 && mPercentageChangeToExclude <= 100);
      }
    }

    private static readonly Random _Random = new Random();
    private bool mEnabled;
    private int mPercentageChangeToExclude;
  }
}