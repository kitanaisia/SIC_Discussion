#!ruby
# -*- coding: utf-8 -*-

#================================================================================
# RUSHの枚数を変動させて以下を調査する
#  * RUSHが初期手札にある確率
#   - RUSHが0枚の確率(まだカバーできる事故)
#   - RUSHが1枚の確率
#   - RUSHが2枚の確率(ベスト)
#   - RUSHが3枚以上ある確率(カバーできない事故)
#
#  * 上記の状態で、デッキトップ登場でRUSHが出る確率
# 
#================================================================================

class Integer
  def combination(k)
    self.factorial/(k.factorial*(self-k).factorial)
  end

  def permutation(k)
    self.factorial/(self-k).factorial
  end

  def factorial
    return 1 if self == 0
    (1..self).inject(:*)
  end
end

# 
# RUSHが手札にi枚ある確率を計算する。
#
# rush_total : デッキ中のRUSHの枚数
# rush_total : 手札に引くRUSHの枚数
#
def rush_in_hand(rush_total, i)
  # constant
  deck_total = 19
  max_hands = 4

  # i枚のRUSHがくる確率を計算
  # 分母
  denominator = deck_total.combination(max_hands)

  # 分子
  numerator = rush_total.combination(i) * (deck_total - rush_total).combination(max_hands - i)
  probability = numerator.to_f / denominator.to_f
  probability

end

# 
# RUSHが手札にi枚ある確率を計算する。
#
# rush_total : デッキ中のRUSHの枚数
# rush_total : 手札に引くRUSHの枚数
#
def rush_from_top(rush_total, rush_in_deck)
  # constant
  deck_total = 19
  return rush_in_deck.to_f / deck_total.to_f
end


# ========================================

for rush_total in 1..9 do
  puts "================================"
  puts "RUSH総計%d枚の場合" % rush_total

  # RUSHが手札にi枚ある確率
  rush_hand = Array.new(5,0)
  for i in 0..4 do
    if rush_total < i
      next
    end
    rush_hand[i] = rush_in_hand(rush_total, i)
  end

  # RUSHが手札にi枚ある時にトップからRUSHを捲れる確率
  rush_top = Array.new(5,0)
  for i in 0..4 do
    if rush_total < i
      next
    end
    rush_top[i] = rush_from_top(rush_total, rush_total - i)
  end

  for i in 0..4 do
    puts "RUSHが%d枚の確率  :%.2f%%" % [i, rush_hand[i]* 100 ]
    # puts "RUSHが%d枚の時にTOPからRUSHを捲れる確率 :%.2f%%" % [i, rush_top[i] * 100 ]
  end

  for i in 0..1 do
    puts "RUSHが%d枚かつTOPからRUSHを捲れる確率 :%.2f%%" % [i, rush_hand[i] * rush_top[i] * 100]
  end

  #
  # 自らがよしとするパターンを以下3つとする
  # 1. RUSHが0枚かつTOPからRUSHを捲れる確率
  # 2. RUSHが1枚かつTOPからRUSHを捲れる確率

  ideal = ( (rush_hand[0] * rush_top[0]) + (rush_hand[1] * rush_top[1]) ) * 100
  puts "理想:%.2f%%" % ideal

  puts "================================"
end
