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
- [GET All Merchants](http://localhost:3000/api/v1/merchants)
- [GET One Merchant](http://localhost:3000/api/v1/merchants/42)
- [GET a Merchant's Items](http://localhost:3000/api/v1/merchants/42/items)


Database Schema
![database](https://user-images.githubusercontent.com/24997456/119401465-c1f45c00-bc98-11eb-8fd2-7ac73765e593.png)


