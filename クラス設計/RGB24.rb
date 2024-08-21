# RGB24という名前のクラスを作成します。クラスはオブジェクトの設計図のようなものです。
class RGB24
  # attr_readerを使用して、red, green, blueを読み取り専用にします。
  attr_reader :red, :green, :blue

  # initializeメソッドは、クラスのコンストラクタです。インスタンスを初期化します。
  def initialize(red, green, blue)
    self.red = red
    self.green = green
    self.blue = blue
  end

  # red, green, blueに対するセッターを定義し、範囲チェックを行います。
  def red=(value)
    @red = validate_color(value)
  end

  def green=(value)
    @green = validate_color(value)
  end

  def blue=(value)
    @blue = validate_color(value)
  end

  # get_hexメソッドは、red, green, blueの値を16進数に変換し、それらを連結した文字列を返します。
  def generate_hex
    hex = format('%02x', @red)
    hex += format('%02x', @green)
    hex += format('%02x', @blue)
    hex
  end

  # get_bitsメソッドは、red, green, blueの値をそれぞれ8ビットの2進数に変換し、それらを連結した文字列を返します。
  def generate_bits
    bits = format('%08b', @red)
    bits += format('%08b', @green)
    bits += format('%08b', @blue)
    bits
  end

  # 最大の色の値を返す。値が同じ場合はnilを返します。
  def determine_greatest_color
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

  # 色の名前を決定し、文字列として返します。
  def determine_color_shade
    color = determine_greatest_color
    case color
    when @red
      'red'
    when @green
      'green'
    when @blue
      'blue'
    else
      'gray'
    end
  end

  private

  # カラー値が0から255の範囲内であることを確認するメソッド。
  def validate_color(value)
    raise ArgumentError, 'Color value must be between 0 and 255' unless value.between?(0, 255)
    value
  end
end

# RGB24を継承したクラスの例として、CMYKクラスを定義します。
class CMYK < RGB24
  attr_reader :cyan, :magenta, :yellow, :key

  def initialize(red, green, blue)
    super(red, green, blue)
    calculate_cmyk
  end

  # RGB値をCMYK値に変換するメソッド。
  def calculate_cmyk
    r_prime = @red / 255.0
    g_prime = @green / 255.0
    b_prime = @blue / 255.0

    k = 1.0 - [r_prime, g_prime, b_prime].max
    k = k.round(4)

    @cyan = ((1.0 - r_prime - k) / (1.0 - k)).round(4)
    @magenta = ((1.0 - g_prime - k) / (1.0 - k)).round(4)
    @yellow = ((1.0 - b_prime - k) / (1.0 - k)).round(4)
    @key = k
  end

  def to_s
    "CMYK(#{@cyan}, #{@magenta}, #{@yellow}, #{@key})"
  end
end

# メインプログラム
if __FILE__ == $0
  # RGB24クラスの新しいインスタンスを3つ作成し、それぞれをcolor1、color2、color3という変数に格納します。
  color1 = RGB24.new(0, 153, 255)
  color2 = RGB24.new(255, 153, 204)
  color3 = RGB24.new(153, 255, 51)

  # 各色の16進数表現、2進数表現、および色をコンソールに出力します。
  puts "#{color1.generate_hex} <-> #{color1.generate_bits}. Color: #{color1.determine_color_shade}"
  puts "#{color2.generate_hex} <-> #{color2.generate_bits}. Color: #{color2.determine_color_shade}"
  puts "#{color3.generate_hex} <-> #{color3.generate_bits}. Color: #{color3.determine_color_shade}"

  # グレースケールの色を表す新しいRGB24インスタンスを作成し、その16進数表現、2進数表現、および色をコンソールに出力します。
  gray = RGB24.new(123, 123, 123)
  puts "#{gray.generate_hex} <-> #{gray.generate_bits}. Color: #{gray.determine_color_shade}"

  # RGB24をCMYKに変換する例
  cmyk_color = CMYK.new(255, 0, 0)
  puts cmyk_color.to_s
end
