module MarshalClone
  # Returns a clone of itelf.
  def clone
    Marshal::load(Marshal.dump(self))
  end
end
