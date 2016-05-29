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
  denominator = deck_total.permutation(max_hands)
  puts "C(%d,%d) = %d" % [deck_total, max_hands, denominator]

  # 分子
  numerator = rush_total.permutation(i) * (deck_total - rush_total).permutation(max_hands - i)
  puts "C(%d,%d) / C(%d,%d) = %d" % [rush_total, i, (deck_total - rush_total), (max_hands - i), numerator]

  probability = numerator.to_f / denominator.to_f

  print "手札にRUSHが%d枚の確率: "% i
  puts "%.2f%%" % (probability.to_f * 100)
  puts 
end

# ========================================

for rush_total in 5..9 do
  puts "================================"
  puts "RUSH総計%d枚の場合" % rush_total
  for i in 0..4 do
    rush_in_hand(rush_total, i)
  end
  puts "================================"
end
