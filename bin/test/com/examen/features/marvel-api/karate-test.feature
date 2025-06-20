# based on automation-guidelines.md instructions, suggest me a feature file
@REQ_BDR-100 @BDR-100 @marvel_api @Agente2 @E2 @marvel_manager
Feature: BDR-100 Get character by id
  As a user of the Marvel API
  I want to retrieve character details by ID
  So that I can view specific character information

  Background:
    * url port_marvel_api

  @id:1 @get_characters @response_200
  Scenario: T-API-BDR-100-CA01 Retrieve characters
    Given path 'characters'
    When method get
    Then status 200
    * print response

  @id:2 @get_character_by_id @response_200
  Scenario: T-API-BDR-100-CA02 Retrieve character by ID
    Given path 'characters', 1
    When method get
    Then status 200
    * print response
    * def characterId = response.id
    * print characterId
    And match characterId == 1

  @id:3 @create_character @response_200
  Scenario: T-API-BDR-100-CA03 Create a new character
    * def jsonData = read('classpath:data/marvel_api/test01_post_caracter_req.json')
    Given path 'characters'
    And request jsonData
    When method post
    Then status 200
    * print response
    * def createdCharacterId = response.id
    * print createdCharacterId
    And match createdCharacterId != null

  @id:4 @create_existing_character @response_400
    Scenario: T-API-BDR-100-CA04 Attempt to create an existing character
    * def jsonData = read('classpath:data/marvel_api/test02_post_caracter_req.json')
    Given path 'characters'
    And request jsonData
    When method post
    Then status 400
    * print response
