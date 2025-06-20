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

  @id:3 @create_character @response_201
  Scenario: T-API-BDR-100-CA03 Create a new character
    * def shareUuid = java.util.UUID.randomUUID().toString()
    * def jsonData = read('classpath:data/marvel_api/test03_post_character_req.json')
    * set jsonData.name = shareUuid
    Given path 'characters'
    And request jsonData
    When method post
    Then status 201
    * print response
    * def createdCharacterId = response.id
    * print createdCharacterId
    And match createdCharacterId != null

  @id:4 @create_existing_character @response_400
  Scenario: T-API-BDR-100-CA04 Attempt to create an existing character
    * def jsonData = read('classpath:data/marvel_api/test04_post_existing_character_req.json')
    Given path 'characters'
    And request jsonData
    When method post
    Then status 400
    * print response
    * def msg = response.error
    And match msg == 'Character name already exists'

  @id:5 @create_invalid_character @response_400
  Scenario: T-API-BDR-100-CA05 Attempt to create an invalid character
    * def jsonData = read('classpath:data/marvel_api/test05_post_invalid_character_req.json')
    Given path 'characters'
    And request jsonData
    When method post
    Then status 400
    * print response
    * def msg = response.description
    And match msg == 'Description is required'

  @id:6 @get_non_existent_character @response_404
  Scenario: T-API-BDR-100-CA06 Attempt to retrieve a non-existent character
    Given path 'characters', 9999
    When method get
    Then status 404
    * print response
    * def msg = response.error
    And match msg == 'Character not found'

  @id:7 @update_character @response_200
  Scenario: T-API-BDR-100-CA07 Update character details
    * def jsonData = read('classpath:data/marvel_api/test06_put_character_req.json')
    Given path 'characters', 1
    And request jsonData
    When method put
    Then status 200
    * print response
    * def powers = response.powers
    * print powers
    And match powers == '#[3]'

  @id:8 @update_non_existent_character @response_404
  Scenario: T-API-BDR-100-CA08 Attempt to update an existing character with the same name
    * def jsonData = read('classpath:data/marvel_api/test07_put_non_existent_character_req.json')
    Given path 'characters', 999
    And request jsonData
    When method put
    Then status 404
    * print response
    * def msg = response.error
    And match msg == 'Character not found'

  @id:9 @delete_character @response_200
  Scenario: T-API-BDR-100-CA09 Delete a character
    * def shareUuid = java.util.UUID.randomUUID().toString()
    * def jsonData = read('classpath:data/marvel_api/test03_post_character_req.json')
    * set jsonData.name = shareUuid
    Given path 'characters'
    And request jsonData
    When method post
    Then status 201
    * print response
    Given path 'characters', response.id
    When method delete
    Then status 204
    * print response

  @id:10 @delete_non_existent_character @response_404
  Scenario: T-API-BDR-100-CA10 Attempt to delete a non-existent character
    Given path 'characters', 9999
    When method delete
    Then status 404
    * print response
    * def msg = response.error
    And match msg == 'Character not found'
