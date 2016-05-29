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

# ========================================

for rush_total in 5..9 do
  puts "================================"
  puts "RUSH総計%d枚の場合" % rush_total
  # for i in 0..4 do
  #   rush_in_hand(rush_total, i)
  # end

  # RUSHが無くて事故っている場合
  rush_non = rush_in_hand(rush_total, 0)
  # RUSHが1,2枚と程よくある場合
  rush_one = rush_in_hand(rush_total, 1)
  rush_two = rush_in_hand(rush_total, 2)
  # RUSHが3,4枚と
  rush_many= rush_in_hand(rush_total, 3) + rush_in_hand(rush_total, 4)

  puts "RUSHがない確率   :%.2f%%" % [ rush_non * 100 ]
  puts "RUSHが1枚の確率  :%.2f%%" % [ rush_one* 100 ]
  puts "RUSHが2枚の確率  :%.2f%%" % [ rush_two* 100 ]
  puts "RUSHが3,4枚の確率:%.2f%%" % [ rush_many * 100 ]
  puts "================================"
end
