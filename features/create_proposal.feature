Feature: Creating proposals

  As a researcher I want to be able to create valid
  proposals, so that I can get funding for my research.

  Background: Logged in as admin
      Given I'm logged in with admin

    Scenario: Attempt to create a proposal while leaving a required field empty
      When  I initiate a proposal but miss a required field
      Then  I should see an error that says the field is required

    Scenario: Attempt to create a proposal with invalid sponsor code
      When  I begin a proposal with an invalid sponsor code
      Then  I should see an error that says a valid sponsor code is required

    Scenario: Selecting a Federal Sponsor activates the S2S tab
      When  I begin a proposal with a 'Federal' sponsor type
      Then  The S2S tab should become available

    Scenario: Valid Proposals can be submitted to routing
      When  I complete a valid simple proposal for a 'Private Profit' organization
      And   I submit the proposal
      Then  The proposal should immediately have a status of 'Approval Pending'
      And   The proposal route log's 'Actions Taken' should include 'COMPLETED'
      And   The proposal's 'Future Action Requests' should include 'PENDING APPROVE' for the principal investigator