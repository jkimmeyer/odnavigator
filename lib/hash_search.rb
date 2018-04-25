module HashSearch
  def nested_hash_value(obj,key)
    # Checks if key is the searched key
    if obj.respond_to?(:key?) && obj.key?(key)
      # returns the found key
      obj[key]
    # check if there is any element in the object.
    elsif obj.respond_to?(:each)
      r = nil
      # Searches the object from back to front, for the key. If it found the key it returns the element, else it will return nil.
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
  end
end
