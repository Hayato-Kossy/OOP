# frozen_string_literal: true
class RGB24 
  attr_accessor :red, :green, :blue
  
  def initialize(red, green, blue)
    @red = red
    @green = green
    @blue = blue
  end

  def get_hex
    hex = format('%02x', @red)
    hex += format('%02x', @green)
    hex += format('%02x', @blue)
    hex
  end
  
  def get_bits
    bits = format('%08b', @red)
    bits += format('%08b', @green)
    bits += format('%08b', @blue)
    bits
  end

  def greatest_color
    if @red > @green && @red > @blue
      @red
    elsif @green > @red && @green > @blue
      @green
    elsif @blue > @red && @blue > @green
      @blue
    else
      nil
    end
  end

  def get_color_shade
    color = greatest_color
    if color == @red
      'red'
    elsif color == @green
      'green'
    elsif color == @blue
      'blue'
    else
      'gray'
    end
  end
end

# メインプログラム
if __FILE__ == $0
  # RGB24クラスの新しいインスタンスを3つ作成し、それぞれをcolor1、color2、color3という変数に格納します。
  color1 = RGB24.new(0, 153, 255)
  color2 = RGB24.new(255, 153, 204)
  color3 = RGB24.new(153, 255, 51)

  # 各色の16進数表現、2進数表現、および色をコンソールに出力します。
  puts "#{color1.get_hex} <-> #{color1.get_bits}. Color: #{color1.get_color_shade}"
  puts "#{color2.get_hex} <-> #{color2.get_bits}. Color: #{color2.get_color_shade}"
  puts "#{color3.get_hex} <-> #{color3.get_bits}. Color: #{color3.get_color_shade}"

  # グレースケールの色を表す新しいRGB24インスタンスを作成し、その16進数表現、2進数表現、および色をコンソールに出力します。
  gray = RGB24.new(123, 123, 123)
  puts "#{gray.get_hex} <-> #{gray.get_bits}. Color: #{gray.get_color_shade}"
end