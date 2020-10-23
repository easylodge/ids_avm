module IdsAvm::Search
  extend self

  def property(options={})
    query_keys = [:state, :address_query]
    required_keys = [:address_query]
    validate_query_params(required_keys, options)
    search('/properties/search', options.slice(*query_keys))['addresses']
  end

  def advanced_property(options={})
    query_keys = [:state, :street_full, :unit_number, :locality, :postcode, :street_number]
    required_keys = query_keys - [:unit_number]
    validate_query_params(required_keys, options)
    search('/properties/search/advanced', options.slice(*query_keys))
  end

  def gnaf_property(property_id)
    raise("Please provide the GNAF Address PID for the property") unless property_id.present?
    search('/properties/search/gnaf', { gnaf_pid: property_id })
  end

  def property_details(property_id)
    raise("Please provide the property ID") unless property_id.present?
    search("/properties/#{property_id}")
  end

  def property_avm_estimate(property_id, options={})
    raise("Please provide the property ID") unless property_id.present?
    query_keys = [:date, :landarea, :bathrooms, :bedrooms, :carparks]
    options.deep_symbolize_keys!
    search("/properties/#{property_id}/estimates", options.slice(*query_keys))
  end

  def property_avm_detailed_estimate(property_id, options={})
    raise("Please provide the property ID") unless property_id.present?
    query_keys = [:date, :landarea, :bathrooms, :bedrooms, :carparks, :max_estimate_range_percent, :desired_coverage_probability_percent]
    options.deep_symbolize_keys!
    search("/properties/#{property_id}/estimates/detail", options.slice(*query_keys))
  end

  def property_avm_report(property_id, options={})
    raise("Please provide the property ID") unless property_id.present?
    query_keys = [:date, :landarea, :bathrooms, :bedrooms, :carparks]
    options.deep_symbolize_keys!
    search("/properties/#{property_id}/estimates/reports", options.slice(*query_keys).merge(response_format: :json))
  end

  def property_images(property_id)
    raise("Please provide the property ID") unless property_id.present?
    search("/properties/#{property_id}/images")['images']
  end

  def property_listings(property_id)
    raise("Please provide the property ID") unless property_id.present?
    search("/properties/#{property_id}/listings")
  end

  def property_sales(property_id)
    raise("Please provide the property ID") unless property_id.present?
    search("/properties/#{property_id}/sales")
  end

  def region_indices(options={})
    query_keys = [:start, :end, :property_type, :stat, :level]
    validate_query_params(query_keys, options)
    restricted_values = [{ title: 'Region', incoming: options[:region], allowed: ['sa3', 'sa4', 'city', 'locality', 'postcode', 'lga'] },
                         { title: 'Interval', incoming: options[:interval], allowed: ['monthly', 'quarterly'] },
                         { title: 'Property type', incoming: options[:property_type], allowed: ['house', 'unit', 'dwelling'] },
                         { title: 'Stat', incoming: options[:stat], allowed: ['tom', 'price', 'vee', 'yields', 'rents', 'salecounts', 'marketscore'] },
                         { title: 'Level', incoming: options[:level], allowed: [] }]

    restricted_values.each do |set|
      validate_path_params(set[:title], set[:incoming], set[:allowed])
    end

    search("/indices/#{options[:interval]}/#{options[:region]}", options.slice(*query_keys))
  end

  def suburb_summary(options={})
    query_keys = [:property_type, :suburb, :bedrooms, :postcode]
    required_keys = query_keys - [:bedrooms]
    validate_query_params(required_keys, options)
    search("/localities/summary", options.slice(*query_keys))
  end

  private

  def validate_path_params(title, value, permitted=[])
    raise("#{title.capitalize} must be one of #{permitted.join(', ')}") unless permitted.include?(value)
  end

  def validate_query_params(required=[], query={})
    query.deep_symbolize_keys!
    required.all? { |s| query.key?(s) && query[s].present? || raise("Required value #{s} not provided.") }
  end

  def search(url, query={})
    IdsAvm::Request.get(url, query)
  end
end