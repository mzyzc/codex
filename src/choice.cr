require "./scene"

class Choice
    @name : String
    @text : String
    @trigger : Proc(String, Bool)
    @next_scene : Scene

    def initialize(@name, @text, @trigger, @next_scene)
    end

    def run()
        puts @text
    end

    def triggered?(input : String)
        return @trigger.call(input)
    end
end