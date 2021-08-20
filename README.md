## Rails Engine
Rails Engine is a Rails-based API which mimics an e-commerce platform reporting tool as an API. Users can query and store merchants and items, and retrieve information about an item's merchant, or a list of a merchant's items. Users can also run one of several "business intelligence" endpoints to do rich reporting using ActiveRecord queries.

## Versions
- Rails 5.2.6
- Ruby 2.5.3
- Bundler 2.1.4

## Setup
Run through the standard Rails setup.

```$ bundle install```

```$ rake db:{create,migrate}```

```$ rails s```

Navigate to http://localhost:3000

Database Schema
![database](https://user-images.githubusercontent.com/24997456/119401465-c1f45c00-bc98-11eb-8fd2-7ac73765e593.png)


