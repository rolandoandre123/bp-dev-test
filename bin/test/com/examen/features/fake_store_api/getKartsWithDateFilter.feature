# based on automation-guidelines.md instructions, suggest me a feature file
@REQ_BDR-100 @BDR-100 @get_karts_with_date_filter @fake_store_api @Agente2 @E2 @karts_with_date_filter
Feature: BDR-100 Get Karts with Date Filter
  As a user of the Fake Store API
  I want to retrieve karts filtered by date
  So that I can see karts created after a specific date

  Background:
    * url port_fake_store_api

  @id:1 @get_karts_with_date_filter @response_200
  Scenario Outline: T-API-BDR-100-CA01 Retrieve karts created after a specific date
    Given path 'carts'
    And param startdate = "<startDate>"
    And param enddate = "<endDate>"
    When method get
    Then status 200
    * print response
    * def respArrayID = $[*].id
    * print respArrayID
    * def index = respArrayID.indexOf(<cartId>)
    * print index
    * def cart = response[index]
    * print cart
      And match cart.products[*] contains deep {productId: <productId>, quantity: <quantity>}
    Examples:
      | read('classpath:../data/fake_store_api/test01_get_karts_with_date_filter.csv') |

  @id:2 @update_kart @update_cart_200
  Scenario: T-API-BDR-100-CA02-Actualizar carrito exitosamente 200 - karate
    * def jsonData = read('classpath:data/fake_store_api/test02_put_kart_req.json')
    Given path 'carts', 6
    And request jsonData
    When method PUT
    Then status 200

