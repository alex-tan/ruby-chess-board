shared_examples "an a1 coordinate" do
  its(:file)        { should == :a  }
  its(:rank)        { should == 1   }
  its(:square_name) { should == :a1 }
  its(:x)           { should == 0   }
  its(:y)           { should == 0   }
end

shared_examples "an h8 coordinate" do
  its(:file)        { should == :h  }
  its(:rank)        { should == 8   }
  its(:square_name) { should == :h8 }
  its(:x)           { should == 7   }
  its(:y)           { should == 7   }
end

shared_examples "a g6 coordinate" do
  its(:file)        { should == :g  }
  its(:rank)        { should == 6   }
  its(:square_name) { should == :g6 }
  its(:x)           { should == 6   }
  its(:y)           { should == 5   }
end
