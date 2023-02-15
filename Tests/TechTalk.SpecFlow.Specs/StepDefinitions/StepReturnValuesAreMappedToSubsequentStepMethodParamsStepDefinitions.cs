using FluentAssertions;
using System;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Specs.Features;

namespace TechTalk.SpecFlow.Specs.StepDefinitions
{
    public class CustomObject {
        public string Echo;

        public CustomObject(string echo) {
            Echo = echo;
        }
    }
    [Binding]
    public class StepReturnValuesAreMappedToSubsequentStepMethodParamsStepDefinitions
    {
        private ScenarioContext _sc;

        public StepReturnValuesAreMappedToSubsequentStepMethodParamsStepDefinitions(ScenarioContext scenarioContext)
        {
            _sc = scenarioContext;
        }
        [Given(@"a custom object")]
        public CustomObject GivenACustomObject()
        {
            var x = new CustomObject("hello");
            return x;
        }

        [Then(@"the custom object is present in the SC")]
        public void ThenTheCustomObjectIsPresentInTheSC()
        {
            var o = _sc.ScenarioContainer.Resolve<CustomObject>();
            o.Should().NotBeNull();
        }

        [Then(@"the custom object is passed as an argument to step binding methods that request it in their method signature")]
        public void ThenTheCustomObjectIsPassedAsAnArgumentToStepBindingMethodsThatRequestItInTheirMethodSignature(CustomObject c)
        {
            c.Should().NotBeNull();
            c.Echo.Should().Be("hello");
        }

    }
}
