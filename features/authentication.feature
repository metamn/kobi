Feature: Authentication
  In order to access the site
  As a visitor
  I want to login or sign up
  
  Scenario: Visitors must be redirected to login/signup page
    Given I am a visitor
    When I go to the homepage 
    Then I should not see "Iesire"
    
  Scenario: Visitors must be able to sign up
    Given I am a visitor
    When I go to signup page
    And I fill in "Nume utilizator" with "test"
    And I fill in "Adresa email" with "test@test.com"
    And I fill in "Parola" with "test123"
    And I fill in "Confirmare parola" with "test123"
    And I press "Inregistrare cont"
    Then I should see "Inregistrare cont cu succes"
    
  Scenario: Users must be able to log in
    Given I am a registered user with "test", "test@test.com" and "test123"
    When I go to login page
    And I fill in "Adresa email" with "test@test.com"
    And I fill in "Parola" with "test123"
    And I press "Intrare in cont"
    Then I should see "Intrare in cont cu succes"
    
  Scenario: Users must be able to log out
    Given I am logged in
    When I go to dashboard page
    And I follow "Iesire"
    Then I should see "xxx"
