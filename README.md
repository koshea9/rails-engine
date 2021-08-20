## Rails Engine
Rails Engine is a Rails-based API which mimics an e-commerce platform reporting tool as an API. Users can query and store merchants and items, and retrieve information about an item's merchant, or a list of a merchant's items. Users can also run one of several "business intelligence" endpoints to do rich reporting using ActiveRecord queries.

## Versions
- Rails 5.2.6
- Ruby 2.5.3
- Bundler 2.1.4

## Setup
1. Fork and clone the repo

2. Install gem packages `$ bundle install`

3. Setup the database `$ rails db:{drop,create,migrate,seed}` and `$ rails db:schema:dump`

4. Run test suite `$ bundle exec rspec`

4. Start local server `$ rails s`

Navigate to http://localhost:3000

## Endpoint Examples
Business Intelligence
- [GET Merchants with Most Revenue](http://localhost:3000/api/v1/revenue/merchants?quantity=10)
- [GET Merchants who Sold Most Items](http://localhost:3000/api/v1/merchants/most_items?quantity=8)
- [GET Revenue of a Single Merchant](http://localhost:3000/api/v1/revenue/merchants/42)
- [GET Potential Revenue of Unshipped Orders](http://localhost:3000/api/v1/revenue/unshipped)

Merchants
- [GET All Merchants](http://localhost:3000/api/v1/merchants)
- [GET One Merchant](http://localhost:3000/api/v1/merchants/42)
- [GET a Merchant's Items](http://localhost:3000/api/v1/merchants/42/items)
- [GET Find All Merchants by Name Fragment](http://localhost:3000/api/v1/merchants/find_all?name=ILL)

Items
- [GET All Items](http://localhost:3000/api/v1/items)
- [GET One Item](http://localhost:3000/api/v1/items/179)
- [GET an Item's Merchant](http://localhost:3000/api/v1/items/11/merchant)
- [GET Find One Item by Name Fragment](http://localhost:3000/api/v1/items/find?name=hArU)

Error Handling Examples
- [String Instead of Integer](http://localhost:3000/api/v1/merchants/string-instead-of-integer)
- [Merchant does not exist](http://localhost:3000/api/v1/merchants/8923987297)


Database Schema
![database](https://user-images.githubusercontent.com/24997456/119401465-c1f45c00-bc98-11eb-8fd2-7ac73765e593.png)


