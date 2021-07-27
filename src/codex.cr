require "./scene"
require "./choice"

# TODO: Write documentation for `Codex`
module Codex
  VERSION = "0.1.0"

  class Game
    @title : String
    @author : String | Nil
    @date : String | Nil
    @prompt : Char
    @scenes : Hash(String, Scene)
    @choices : Hash(String, Choice)
  
    def initialize(@title, @author = nil, @date = nil, @prompt = '>')
      @scenes = {} of String => Scene
      @choices = {} of String => Choice
    end

    def run(scene_name : String)
      # Preamble
      puts @title
      puts "#{@author}, #{@date}"

      # Scene loop
      scene = @scenes[scene_name]
      while scene
        scene.run

        # Get user input
        while true
          print "#{@prompt} "
          input = gets
          next if input.nil?

          scene.@choices.each do |choice|
            if choice.triggered?(input)
              scene = choice.@next_scene
              break
            else
              puts "Action not recognised"
            end
          end
        end
      end
    end
      
    def add_scene(name : String, *, text : String, choices : Array(String))
      @scenes[name] = Scene.new(name, text, get_choices(choices))
    end

    def add_choice(name : String, *, text : String, trigger : Proc, next_scene : String)
      @choices[name] = Choice.new(name, text, trigger, @scenes[next_scene])
    end

    def get_choices(choices : Array(String))
      choice_list = [] of Choice
      choices.each do |choice|
        choice_list << @choices[choice]
      end
      return choice_list
    end
  end
end