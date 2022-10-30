Feature: Rule Background Steps Execution

    Scenario: Should be able to execute scenarios in Rules that have backgrounds
    Given there is a feature file in the project as
        """
            Feature: Simple Feature
            Rule: first rule
            Background: first rule background
                Given something first as background
            
            Scenario: Scenario for the first rule
                When I do something
                Then the first background item was executed

        """

  	And the following binding class
		 """
         using TechTalk.SpecFlow;

		 [Binding]
		 public class RuleSteps
		 {
            private bool first_backgound_executed = false;

			[Given("something first as background")]
			public void GivenSomethingFirst() {
                global::Log.LogStep();
                first_background_executed = true;
            }

            [Then("the first background item was executed")]
            public void ThenFirstWasExecuted() {
                Assert(first_background_executed);
            }
		 }
		 """

    Given all steps are bound and pass
    When I execute the tests
    Then the scenario should pass


    Scenario: Should be able to execute backgrounds from multiple Rules
    Given there is a feature file in the project as
        """
            Feature: Simple Feature
            Rule: first rule
                Background: first rule background
                    Given something first as background
            
                Scenario: Scenario for the first rule
                    When I do something
                    Then the first background item was executed
                    And the second background item was not executed

            Rule: second rule
                Background: bg for second rule
                    Given something second as background

                Scenario:Scenario for the second rule
                    When I do something
                    Then the second background item was executed
                    And the first background item was not executed

        """

  	And the following binding class
		 """
         using TechTalk.SpecFlow;

		 [Binding]
		 public class RuleSteps
		 {
            private bool first_backgound_executed = false;
            private bool second_background_executed = false;

			[Given("something first as background")]
			public void GivenSomethingFirst() {
                global::Log.LogStep();
                first_background_executed = true;
            }

            [Then("the first background item was executed")]
            public void ThenFirstWasExecuted() {
                Assert(first_background_executed);
            }

            [Then("the first background item was not executed")]
            public void ThenFirstWasNotExecuted() {
                Assert(!first_background_executed);
            }

			[Given("something second as background")]
			public void GivenSomethingSecond() {
                global::Log.LogStep();
                second_background_executed = true;
            }

            [Then("the second background item was executed")]
            public void ThenSecondWasExecuted() {
                Assert(second_background_executed);
            }

            [Then("the second background item was not executed")]
            public void ThenSecondWasNotExecuted() {
                Assert(!second_background_executed);
            }

		 }
		 """

    Given all steps are bound and pass
    When I execute the tests
    Then the scenario should pass
