require_relative '../extensions/hash_deep_merge'

class Params
  
  def initialize(req)
    @query_hash = parse_www_encoded_form(req.query_string)
    @body_hash = parse_www_encoded_form(req.body)
    @params_hash = @query_hash.merge(@body_hash)
  end
  
  def [](key)
    @params_hash[key.to_s]
  end
  
  def to_s
    @params_hash.to_json.to_s
  end
  
  def inspect
    @params_hash
  end
  
  private
  
  def parse_www_encoded_form(www_encoded_form)
    parsed = URI::decode_www_form(www_encoded_form)

    nested_hashes = parsed.each_with_object([]) do |(key, value), hashes|
      keys = parse_key(key)
      hash = {}
      outside_hash = hash

      keys.each do |k|
        if k == keys.last
          hash[k] = value
        else
          hash[k] = {}
          hash = hash[k]
        end
      end

      hashes << outside_hash
    end

    merged_hash = nested_hashes.pop
    nested_hashes.each do |hash|
      merged_hash = merged_hash.deep_merge(hash)
    end
    merged_hash
  end

  def parse_key(key)
    key.split(/\[|\]\[|\]/)
  end
  
end