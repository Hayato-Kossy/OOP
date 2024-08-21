# frozen_string_literal: true

# RGB24という名前のクラスを作成します。クラスはオブジェクトの設計図のようなものです。
class RGB24 
  # attr_accessorを使用して、red, green, blueという名前の公開された（public）変数を定義します。
  attr_accessor :red, :green, :blue
  
  # initializeメソッドは、クラスのコンストラクタです。インスタンスを初期化します。
  def initialize(red, green, blue)
    @red = red
    @green = green
    @blue = blue
  end

  # get_hexメソッドは、red, green, blueの値を16進数に変換し、それらを連結した文字列を返します。
  def get_hex
    hex = format('%02x', @red)
    hex += format('%02x', @green)
    hex += format('%02x', @blue)
    hex
  end
  
  # get_bitsメソッドは、red, green, blueの値をそれぞれ8ビットの2進数に変換し、それらを連結した文字列を返します。
  def get_bits
    bits = format('%08b', @red)
    bits += format('%08b', @green)
    bits += format('%08b', @blue)
    bits
  end

  # greatest_colorメソッドは、RGBの値を比較し、最も大きな値を持つ色を返します。値が同じ場合はnilを返します。
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

  # get_color_shadeメソッドは、greatest_colorメソッドを使用して最も大きな色の名前を返します。値が同じ場合は「gray」を返します。
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
