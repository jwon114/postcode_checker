# Postcode Checker

A simple web application to work out if a given postcode is within their service area.

## Requirements

* Postcodes.io REST API for data source.
* Postcodes are grouped into larger blocks called LSOAs. Whitelist any postcode in an LSOA starting "Southwark" or "Lambeth". Example postcodes for those LSOAs are SE1 7QD and SE1 7QA respectively.
* Some postcodes are unknown by the API or may be served despite being outside of the whitelisted LSOAs. These need the ability to be whitelisted anyway even though the API does not recognise them. SH24 1AA and SH24 1AB are both examples of unknown postcodes that we want to serve.
* Any postcode not in the LSOA whitelist or the Postcode whitelist is not servable.
* No guarantees about the format of the input given.
* Whitelists will need to be changed from time to time.

## Getting Started

Download the project and navigate to the project root. 
Execute database setup to create database and seed the postcode whitelist with two postcodes: SH24 1AA and SH24 1AB.

```
rails db:setup
```

Start the rails server:

```
rails start
```

## Testing

To execute unit tests:

```
rails test
```

To execute system tests:

```
rails test:system
```

## Technologies

* Ruby on Rails 6.0.2.1
* Ruby 2.6.5
* Minitest for unit tests
* Capybara for system tests