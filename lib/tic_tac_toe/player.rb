module TicTacToe
  class Player
      attr_accessor :name, :tic_symbol

      def initialize name = nil, tic_symbol
        @name       = name
        @tic_symbol = set_tic_sym tic_symbol
      end


      def tic_symbol= sym
        set_tic_sym sym
      end

      private

      def set_tic_sym sym
        if sym != nil && ['x', 'o'].include?(sym.downcase)
          tic_symbol = sym
        else
          raise 'Not supported symbol, only the \'x\' and \'o\' are supported'
        end
      end
  end
end
