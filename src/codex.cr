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
      scene : Scene | Nil = @scenes[scene_name]
      while scene
        scene.run

        # Get user input
        matches_choice = false
        while !matches_choice
          break if scene.nil?

          print "#{@prompt} "
          input = gets
          next if input.nil?

          scene.@choices.each do |choice_name|
            choice = @choices[choice_name]
            if choice.triggered?(input.downcase)
              matches_choice = true

              if @scenes.has_key?(choice.@next_scene)
                scene = @scenes[choice.@next_scene]
              else
                scene = nil
              end

              choice.run
              break
            end
          end
        end
      end
    end
      
    def add_scene(name : String, *, text : String, choices : Array(String))
      @scenes[name] = Scene.new(name, text, choices)
    end

    def add_choice(name : String, *, text : String, trigger : Proc, next_scene : String | Nil = nil)
      next_scene = next_scene.nil? ? nil : next_scene
      @choices[name] = Choice.new(name, text, trigger, next_scene)
    end

    def edit_scene(name : String, *, text : String | Nil = nil, choices : Array(String) | Nil = nil)
      scene = @scenes[name]
      @scenes[name] = Scene.new(
        name,
        text.nil? ? scene.@text : text,
        choices.nil? ? scene.@choices : choices,
      )
    end

    def edit_choice(name : String, *, text : String | Nil = nil, trigger : Proc | Nil = nil, next_scene : String | Nil = nil)
      choice = @choices[name]
      @choices[name] = Choice.new(
        name,
        text.nil? ? choice.@text : text,
        trigger.nil? ? choice.@trigger : trigger,
        next_scene.nil? ? choice.@next_scene : next_scene,
      )
    end
  end
end