# frozen_string_literal: true

require 'sorbet-runtime'

class Battery
  extend T::Sig

  attr_reader :manufacturer, :model, :voltage, :amp_hours, :weight_kg, :dimension_mm

  # コンストラクタの引数に型制約を追加し、寸法引数をFloat型にキャストします。
  sig { params(manufacturer: String, model: String, voltage: Float, amp_hours: Float, weight_kg: Float, w_mm: Float, h_mm: Float, d_mm: Float).void }
  def initialize(manufacturer, model, voltage, amp_hours, weight_kg, w_mm, h_mm, d_mm)
    @manufacturer = manufacturer
    @model = model
    @voltage = voltage
    @amp_hours = amp_hours
    @weight_kg = weight_kg
    # 引数をFloatにキャスト
    @dimension_mm = [w_mm.to_f, h_mm.to_f, d_mm.to_f]
  end

  # 電力容量を計算するメソッド
  sig { returns(Float) }
  def get_power_capacity
    @voltage * @amp_hours
  end

  # オブジェクトを文字列形式で表現するメソッド
  sig { returns(String) }
  def to_s
    reference_hash = object_id.to_s(16)

    "#{@manufacturer} #{@model}: #{get_power_capacity}Wh (#{@voltage}V/#{@amp_hours}Ah) - #{@dimension_mm[0]}(W)x#{@dimension_mm[1]}(H)x#{@dimension_mm[2]}(D) #{@weight_kg}kg .... Instance Reference: #{reference_hash}"
  end

  # バッテリーの体積を計算するメソッド
  sig { returns(Float) }
  def get_volume
    @dimension_mm.reduce(:*)
  end

  # 他のバッテリーオブジェクトと等しいかどうかを比較するメソッド
  sig { params(battery: Battery).returns(T::Boolean) }
  def isEquals(battery)
    self == battery
  end

  # 他のバッテリーオブジェクトよりも大きいかどうかを比較するメソッド
  sig { params(battery: Battery).returns(T::Boolean) }
  def isBigger(battery)
    get_volume > battery.get_volume
  end

  # isEquals と isBigger を利用して、他のバッテリーと同等またはそれ以上かを判断するメソッド
  sig { params(battery: Battery).returns(T::Boolean) }
  def isBiggerOrEqual(battery)
    isEquals(battery) || isBigger(battery)
  end

  # 他のバッテリーよりも小さいかどうかを判断するメソッド
  sig { params(battery: Battery).returns(T::Boolean) }
  def isSmaller(battery)
    !isBiggerOrEqual(battery)
  end

  # 他のバッテリーと同等またはそれ以下かを判断するメソッド
  sig { params(battery: Battery).returns(T::Boolean) }
  def isSmallerOrEqual(battery)
    !isBigger(battery)
  end
end
