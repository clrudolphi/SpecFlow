Feature: StepReturnValuesAreMappedToSubsequentStepMethodParams

An experiment


Scenario: When a given Step method returns a custom object, that object is placed in to the Scenario Context
	Given a custom object
	Then the custom object is present in the SC
	And the custom object is passed as an argument to step binding methods that request it in their method signature
