require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "StringIO#readline" do
  before(:each) do
    @io = StringIO.new("r e a d")
    @io_para = StringIO.new("\n\n\n\npara1-1\npara1-2\n\n\npara2-1\npara2-2\n\n\n\n")
    @io_empty_lines = StringIO.new("\n\n\n\n\n\n\n\n\n\n\n")
  end

  it "returns the next 'line'" do
    @io.readline.should == 'r e a d'
  end

  it "raises an EOFError at the end" do
    @io.readline
    lambda { @io.readline }.should raise_error(EOFError)

    @io_para.readline("")
    @io_para.readline("")
    lambda { @io_para.readline("") }.should raise_error(EOFError)

    lambda {@io_empty_lines.readline("")}.should raise_error(EOFError)
  end

  it "raises an IOError when it is not open for reading" do
    @io.close_read
    lambda { @io.readline }.should raise_error(IOError)
  end

  it "support separator strings" do
    @io.readline('e').should == 'r e'
    @io.readline('e').should == ' a d'
  end

  it "returns the next paragrah when separator is an empty string" do
    @io_para.readline("").should == "para1-1\npara1-2\n"
    @io_para.readline("").should == "para2-1\npara2-2\n"
  end

  it "returns the entire content if separator is nil" do
    @io_para.readline(nil).should == @io_para.string
  end
end
