# typed: false
# Contains a method that allows a deep clone of the object
# using the Ruby Marshal class.
module MarshalClone
  # Returns a clone of itelf.
  def clone
    Marshal::load(Marshal.dump(self))
  end
end
