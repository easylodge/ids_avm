# ids_avm
IDS service integration

Ruby gem to make API requests to IDS's AVM public service. Website: [https://www.ids.io/](https://www.ids.io/)

[API Guide](https://developer.ids.io/)

## Installation

Add this line to your application's Gemfile:

    gem 'ids_avm'

And then execute:

    $ bundle

Then run install generator:

	rails g ids_avm:install

Then run migrations:

    rake db:migrate

## Usage

### Functions

The `IdsAvm::Search` class gives access to the following functions as class methods;

1. `property(options={})`

    Search for a property using the provided address query string

    Acceptable attributes for options hash:

        {
            state: ...,
            address_query: ...
        }

    Required attributes: `address_query`

2. `advanced_property(options={})`

    Search for a property using individual address fields. Particularly useful when you have already obtained the address data from Google Places API, in which case note the mappings notes on each of the query parameters.

    Acceptable attributes for options hash:

        {
            state: ...,
            street_full: ...,
            unit_number: ...,
            locality: ...,
            postcode: ...,
            street_number: ...
        }

    Required attributes: All attributes are required except `unit_number`



3. `gnaf_property(property_id)`

    GNAF Address PID based search

    `property_id` is The GNAF Address PID for the property


4. `property_details(property_id)`

    Retrieve details for a specific property.


5. `property_images(property_id)`

    Returns an array of images, with the following fields for each image:

        - url - URL to retrieve the image
        - date - date that the image was created
        - rank - the order from low to high in which the images can be displayed, use this to make sure you don't show a picture of the bathroom as the primary image


6. `property_listings(property_id)`

    Retrieve the list of historical listings for a specific property.


7. `property_sales(property_id)`

    Retrieve the list of historical sales for a specific property.


8. `property_avm_estimate(property_id, options={})`

    Retrieve estimated value for a specific property. Any property attribute value passed in with the request overrides the value for that attribute in the IDS property database.

    Acceptable attributes for options hash:

        {
            date: ...,
            landarea: ...,
            bathrooms: ...,
            bedrooms: ...,
            property_type: ...,
            carparks: ...
        }

    Required attributes: none


9. `property_avm_detailed_estimate(property_id, options={})`

    Retrieve detailed estimated value for a specific property. Any property attribute value passed in with the request overrides the value for that attribute in the IDS property database.

    Acceptable attributes for options hash:

        {
            date: ...,
            landarea: ...,
            bathrooms: ...,
            bedrooms: ...,
            property_type: ...,
            carparks: ...,
            max_estimate_range_percent: ...,
            desired_coverage_probability_percent: ...
        }

    Required attributes: none


10. `property_avm_report(property_id, options={})`

    Retrieve AVM report for a specific property, with optional estimate date and property attributes. Any property attribute value passed in with the request overrides the value for that attribute in the IDS property database.

    Acceptable attributes for options hash:

        {
            date: ...,
            landarea: ...,
            bathrooms: ...,
            bedrooms: ...,
            carparks: ...
        }

    Required attributes: none


11. `suburb_summary(options={})`

    Returns summary statistics for a suburb in the previous 12 months for the type of property (house or unit) and number of bedrooms passed in with the call.

    Acceptable attributes for options hash:

        {
            property_type: ...,
            suburb: ...,
            bedrooms: ...,
            postcode: ...
        }

    Required attributes: All attributes are required except `bedrooms`


12. `region_indices(options={})`

    Returns a time series for the requests statistic

    Acceptable attributes for options hash:

        {
            region: ...,
            interval: ...,
            start: ...,
            end: ...,
            property_type: ...,
            stat: ...,
            level: ...
        }

    Required attributes: All attributes are required



## Contributing

1. Fork it ( http://github.com/easylodge/ids_avm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. See dev.rb file in root
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
