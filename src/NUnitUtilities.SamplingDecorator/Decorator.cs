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
      decorators.Install(this);
      return true;
    }

    public Test Decorate(Test test, MemberInfo member) {
      if (_Random.Next(1, 100) < 50)
        test.RunState = RunState.Explicit;
      return test;
    }

    private static readonly Random _Random = new Random();
  }
}