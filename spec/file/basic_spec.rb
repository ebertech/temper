require 'spec_helper'

describe Temper::File do
  let(:sample_text_file){
    File.expand_path("../../examples/sample.txt", __FILE__)
  }
  
  context "uses defaults" do
    context "setting an original filename" do
      subject { Temper::File.new(:original_filename => "foo.txt") }
      its(:original_filename) { should == "foo.txt" }
      its(:content_type) { should == "text/plain" }
    end

    context "with no filename it has a default content type" do
      subject { Temper::File.new }
      its(:content_type) { should == "application/x-octet-stream" }    
    end
  end

  context "uses a file" do
    context "without overriding the filename" do 
      subject { Temper::File.new(:content => __FILE__) }  
      its(:original_filename) { should == File.basename(__FILE__) }  
      its(:content_type) { should == "application/x-ruby" }     
    end
    
    context "without overriding the filename" do 
      subject { Temper::File.new(:original_filename => "foo.txt", :content => __FILE__) }
      its(:original_filename) { should == "foo.txt" }  
      its(:content_type) { should == "text/plain" }     
    end    
    
    context "calculates a fingerprint" do
      subject {  Temper::File.new(:content => sample_text_file) }
      it "should have the same content as the original file" do
         subject.read.should == File.read(sample_text_file)
      end   
      its(:fingerprint) { should == "92974d961d3f7e3f5da0860a97999afa" }
    end
  end
  
  it "raises an error with a non-existant file" do
    path = "/foo/bar/blort"
    expect do 
      Temper::File.new(:content => path) 
    end.to raise_error ArgumentError, "#{path} file does not exist" 
  end
end
