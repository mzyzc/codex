require "./choice"

class Scene
    @name : String
    @text : String
    @choices : Array(Choice)

    def initialize(@name, @text, @choices)
    end

    def run()
        puts @text
    end
end