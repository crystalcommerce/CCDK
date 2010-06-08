module Ccdk
  MODULES = {
    :tdump => 'ccdk/tdump'
  }

  class << self
    def load_all!
      MODULES.values.each do |lib|
        Kernel.require lib
      end
    end

    def load(*sym)
      sym.each do |sym|
        Kernel.require MODULES[sym]
      end
    end
  end
end
