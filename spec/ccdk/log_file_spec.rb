require 'spec_helper'

require 'ccdk/log_file'

module Ccdk
  describe LogFile do
    let(:file_handle){ mock("FH") }
    subject{ LogFile.new('blah') }

    before do
      File.stub(:open).and_return(file_handle)
    end

    describe "::open" do
      context "when the file name ends in '.gz'" do
        it "makes a new GzipLogFile" do
          GzipLogFile.should_receive(:new).with('name.gz')
          LogFile.open('name.gz')
        end
      end

      context "when the file name doesn't end in '.gz'" do
        it "makes a normal log file" do
          LogFile.should_receive(:new).with('name.log')
          LogFile.open('name.log')
        end
      end
    end

    describe "#initialize" do
      it "opens the file (for reading)" do
        File.should_receive(:open).with('name.log', 'r')
        LogFile.new('name.log')
      end
    end

    describe "#each_block" do
      it "yields the next block until the end of file" do
        subject.stub(:next_block).and_return("block")
        file_handle.stub(:eof?).and_return(false, false, true)
        result = []
        subject.each_block{ |b| result << b }
        result.should == ["block", "block"]
      end
    end

    describe "#next_block" do
      it "Reads from the Processing line to a blank one" do
        file_handle.stub(:eof?).and_return(false)
        file_handle.stub(:gets).and_return("Processing: blah",
                                           "blah",
                                           "",
                                           "ommitted")
        subject.next_block.should == "Processing: blah\nblah"
      end
    end

    describe "#close" do
      it "closes the file handle" do
        file_handle.should_receive(:close)
        subject.close
      end
    end
  end

  describe GzipLogFile do
    describe "#initialize" do
      let(:fh){ mock("File handle") }

      before do
        File.stub(:open).and_return(fh)
        Zlib::GzipReader.stub(:new)
      end

      it "opens the file (for reading)" do
        File.should_receive(:open).with('name.gz', 'r')
        GzipLogFile.new('name.gz')
      end

      it "wraps the file in a gzip reader" do
        Zlib::GzipReader.should_receive(:new).with(fh)
        GzipLogFile.new('name.gz')
      end
    end
  end
end
