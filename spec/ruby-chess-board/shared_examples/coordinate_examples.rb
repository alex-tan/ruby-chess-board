shared_examples "an a1 coordinate" do
  its(:x) { should == 0 }
  its(:y) { should == 0 }
  its(:square_name) { should == :a1 } 
  its(:file) { should == :a }
  its(:rank) { should == 1 }
end

shared_examples "an h8 coordinate" do
  its(:x) { should == 7 }
  its(:y) { should == 7 }
  its(:square_name) { should == :h8 }
  its(:file) { should == :h }
  its(:rank) { should == 8 }
end

shared_examples "a g6 coordinate" do
  its(:x) { should == 6 }
  its(:y) { should == 5 }
  its(:square_name) { should == :g6 }
  its(:file) { should == :g }
  its(:rank) { should == 6}
end
