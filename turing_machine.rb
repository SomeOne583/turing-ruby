# 8 operadores
# [] loop
# . stdout
# , stdin
# + increase
# - decrease
# <> move

class TurnigMachine
    def initialize
        @posicion = 0
        @cinta = [0]
    end

    def show_tape
        @cinta.size.times do
            |i|
            i == @posicion ? (print "[#{@cinta[i]}]  ") : (print "#{@cinta[i]}  ")
        end
        puts ""
    end

    def execute(instrucciones)
        index = 0
        substring = []
        control = 0
        # loopeable = []
        while index < instrucciones.length
            c = instrucciones[index]
            case c
            when '+'
                @cinta[@posicion] += 1
            when '-'
                @cinta[@posicion] -= 1
            when '>'
                @cinta << 0 if @posicion == @cinta.size - 1
                @posicion += 1
            when '<'
                @posicion -= 1
            when '.'
                print "#{@cinta[@posicion]}  "  
            when ','
                @cinta[@posicion] = gets.chomp.to_i
            when '['
                (substring << index) if control == 0
                control += 1
            when ']'
                # puts control
                control == 1 ? (substring << index) : (control -= 1)
                # puts control
            end
            index += 1
            if substring.size == 2
                loopeable = instrucciones[substring[0] + 1...substring[1]]
                while @cinta[@posicion] > 0
                    self.execute(loopeable)
                end
                index = substring[1] + 1
                substring = []
            end
            # self.show_tape
        end
    end
end

# print "Instrucciones: "
# instrucciones = gets.chomp
# instrucciones = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
# instrucciones = "++[>++[>++[>++[>++<-]<-]<-]<-]"
# instrucciones = "+[-->-[>>+>-----<<]<--<---]>-.>>>+.>>..+++[.>]<<<<.+++.------.<<-.>>>>+."
instrucciones = ",[>+>+<<-]"
turing1 = TurnigMachine.new
turing1.execute(instrucciones)
puts ""
turing1.show_tape
