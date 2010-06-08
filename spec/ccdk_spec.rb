require 'spec_helper'

describe Ccdk do
  before do
    # Constant? Hah!
    Ccdk::MODULES.clear
    Ccdk::MODULES[:fake]  = 'ccdk/fake_module'
    Ccdk::MODULES[:fake2] = 'ccdk/fake_2'
  end
  describe '::load_all!' do
    it "requires every module listed in MODULES" do
      Kernel.should_receive(:require).with('ccdk/fake_module')
      Kernel.should_receive(:require).with('ccdk/fake_2')
      Ccdk.load_all!
    end
  end

  describe '::load' do
    it "loads a single symbol passed to it" do
      Kernel.should_receive(:require).with('ccdk/fake_2')
      Ccdk.load :fake2
    end

    it "loads each of a list of symbols passed to it" do
      Kernel.should_receive(:require).with('ccdk/fake_module')
      Kernel.should_receive(:require).with('ccdk/fake_2')
      Ccdk.load :fake, :fake2
    end
  end
end
