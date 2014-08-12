class Hash

  def deep_merge(hash)
    self.merge!(hash) do |key, old_val, new_val|
      (old_val.class == Hash) ? old_val.deep_merge(new_val) : new_val
    end
  end
  
end