require 'spec_helper'

describe Temper::StringIO do
  context "empty content" do
    subject { Temper::StringIO.new}
    its(:original_filename) { should == "stringio.txt" }
    its(:content_type) { should == "text/plain" }
  end
  
  context "custom filename" do
    subject { Temper::StringIO.new(:original_filename => "foo.txt") }
    its(:original_filename) { should == "foo.txt" }
    its(:content_type) { should == "text/plain" }    
  end

  context "custom content_type" do
    subject { Temper::StringIO.new(:content_type => "text/html") }
    its(:original_filename) { should == "stringio.txt" }
    its(:content_type) { should == "text/html" }    
  end
  
  context "should calculate fingerprint" do
    context "empty content" do
      subject { Temper::StringIO.new() }
      its(:fingerprint) { should == "d41d8cd98f00b204e9800998ecf8427e" }      
    end
    
    context "normal content" do
      subject { Temper::StringIO.new(:content => "foo") }
      its(:fingerprint) { should == "acbd18db4cc2f85cedef654fccc4a4d8" }            
    end
  end

end
