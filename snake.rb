require 'gosu'

TILE_SIZE = 25

class GameWindow < Gosu::Window
  def initialize
    super(1024, 768, false)
    self.caption = "Snake Game"
    @head = {
      x: TILE_SIZE * 5, y: TILE_SIZE * 4, new_direction: :up,
      w: TILE_SIZE, h: TILE_SIZE, r: 120, g: 220, b: 120
    }
    @parts = []
    @apple = spawn_apple
    @game_over = false
    @font = Gosu::Font.new(20)
    @frame_modulo = 100
  end

  def update
    unless @game_over
      if Gosu.milliseconds % 2.5 == 0
        prev_pos = [@head[:x], @head[:y]]

        @head[:direction] = @head[:new_direction]
        case @head[:direction]
        when :up
          @head[:y] += TILE_SIZE
        when :down
          @head[:y] -= TILE_SIZE
        when :left
          @head[:x] -= TILE_SIZE
        when :right
          @head[:x] += TILE_SIZE
        end

        @parts.each do |p|
          next_prev_pos = [p[:x], p[:y]]
          p[:x], p[:y] = prev_pos
          prev_pos = next_prev_pos
        end

        if @parts.any? { |p| intersect_rect?(@head, p) }
          @game_over = true
        end
      end

      if @head[:x] >= self.width
        @head[:x] = 0
      elsif @head[:x] < 0
        @head[:x] = self.width - @head[:w]
      elsif @head[:y] >= self.height
        @head[:y] = 0
      elsif @head[:y] < 0
        @head[:y] = self.height - @head[:h]
      end

      if @head[:direction] == :up || @head[:direction] == :down
        @head[:new_direction] = :right if button_down?(Gosu::KbRight)
        @head[:new_direction] = :left if button_down?(Gosu::KbLeft)
      else
        @head[:new_direction] = :up if button_down?(Gosu::KbDown)
        @head[:new_direction] = :down if button_down?(Gosu::KbUp)
      end

      if intersect_rect?(@head, @apple)
        @parts << @head.clone.merge({ r: 60, b: 34 })
        @apple = spawn_apple
      end
    else
      if button_down?(Gosu::KbSpace)
        initialize
      end
    end
  end

  def draw
    fps_text = "FPS: #{Gosu.fps}"
    @font.draw_text(fps_text, 20, 20, 1, 1.0, 1.0, Gosu::Color::WHITE)
    draw_rect(@head)
    @parts.each { |part| draw_rect(part) }
    draw_rect(@apple)
    @font.draw_text("Score: #{@parts.length}", 20, 40, 1)
    if @game_over
      @font.draw_text("press Space to Restart", 400, 350, 1)
    end
  end

  def intersect_rect?(rect1, rect2)
    rect1[:x] < rect2[:x] + rect2[:w] &&
    rect1[:x] + rect1[:w] > rect2[:x] &&
    rect1[:y] < rect2[:y] + rect2[:h] &&
    rect1[:y] + rect1[:h] > rect2[:y]
  end

  def draw_rect(rect)
    Gosu.draw_rect(rect[:x], rect[:y], rect[:w], rect[:h], Gosu::Color.new(rect[:r], rect[:g], rect[:b]))
  end

  def spawn_apple
  {
    x: rand(self.width / TILE_SIZE) * TILE_SIZE,
    y: rand(self.height / TILE_SIZE) * TILE_SIZE,
    w: TILE_SIZE, h: TILE_SIZE, r: 200, g: 40, b: 40
  }
  end
end

  window = GameWindow.new
  window.show
