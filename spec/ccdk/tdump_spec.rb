require 'spec_helper'

require 'erb'
require 'stringio'

module Ccdk
  describe TDump do
    class DumpObject
      include TDump
      attr_accessor :name
    end

    describe "#tdump" do
      let(:model){ DumpObject.new }

      context "when passed an ERB" do
        it "substitutes model data into the template" do
          model.name = "model_name"
          erb = ERB.new "Name is '<%= name %>'!"
          model.tdump(erb).should == "Name is 'model_name'!"
        end
      end

      context "when passed a string template" do
        it "substitutes model data into the string as a template" do
          model.name = "Model"
          model.tdump("Hello, <%= name %>.").should == "Hello, Model."
        end
      end

      context "when passed a path to a file" do
        before do
          File.stub(:exist?).and_return(true)
        end

        it "reads the file" do
          File.should_receive(:read).with('/some/file/location.erb').
            and_return('')
          model.tdump('/some/file/location.erb')
        end

        it "substitutes for the file's template" do
          model.name = "model name"
          File.stub(:read).and_return("<%= name %> says, 'Hi!'")
          model.tdump('/some/file/location.erb')
        end
      end

      context "when passed something #read able (like a file)" do
        it "reads the input and substitutes for the included template" do
          model.name = "Name"
          io = StringIO.new("Hi <%= name %> (from an IO!)")
          model.tdump(io).should == "Hi Name (from an IO!)"
        end
      end
    end
  end
end
