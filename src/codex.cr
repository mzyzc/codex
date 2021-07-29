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
      print_preamble(@title, @author, @date)

      # Scene loop
      scene : Scene | Nil = @scenes[scene_name]
      while scene
        scene.run
        puts

        # Get user input
        match : Choice | Nil = nil
        while !match
          break if scene.nil?

          input = get_input
          next if input.nil?

          match = match_choice(input, scene)
          next if match.nil?

          if @scenes.has_key?(match.@next_scene)
            scene = @scenes[match.@next_scene]
          else
            scene = nil
          end

          match.run
          puts
        end
      end
      puts "GAME OVER"
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

    private def print_preamble(title, author, date)
      puts @title

      if author && date
        puts "#{@author}, #{@date}"
      elsif author
        puts author
      elsif date
        puts date
      end

      puts
    end

    private def get_input()
      print "#{@prompt} "
      input = gets
      return input.nil? ? nil : input.downcase
    end

    private def match_choice(input : String, scene : Scene)
      match = nil

      scene.@choices.each do |choice_name|
        choice = @choices[choice_name]
          if choice.triggered?(input)
            match = choice
            break
          end
      end

      return match
    end
  end
end