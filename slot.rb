class Slot
  @@xy = 0
  @@xyy = 0
  @@xyyy = 0
  @@xxy = 0
  @@xxyy = 0
  @@xxyyy = 0
  @@xxxy = 0
  @@xxxyy = 0
  @@xxxyyy = 0
  @@your_coin = 100
  @@your_point = 0
  @@bet_coin = 0

  def self.slot_bet
    if @@your_coin <=0 
      puts "コインがなくなりました。"
      puts "最終結果 : #{@@your_point}ポイント"
      exit
    else
      while true do
        puts "----------------"
        puts "残りコイン数：#{@@your_coin} コイン"
        puts "所持ポイント：#{@@your_point} ポイント"
        puts "何コイン入れますか？"
        puts "1[10コイン] 2[20コイン] 3[50コイン] 4[終了]"
        puts "----------------"
  
        @@bet_coin = gets.to_s.chomp
        case @@bet_coin
        when "4"
          puts "終了します。"
          puts "最終結果 : #{@@your_point}ポイント"
          exit
        when "1","2","3"
        else 
          puts "入力が不正です。"
          redo
        end
  
        @@bet_coin = @@bet_coin.gsub(/1|2|3/,"1" => 10, "2" => 20, "3" => 50).to_i
        if @@bet_coin <= @@your_coin
          break
        else
          puts "コイン不足です。"
        end
      end
    end
  end

  def self.slot_rotate
    @@your_coin = @@your_coin - @@bet_coin
    @@xy = rand(1..9)
    @@xyy = rand(1..9)
    @@xyyy = rand(1..9)
    @@xxy = rand(1..9)
    @@xxyy = rand(1..9)
    @@xxyyy = rand(1..9)
    @@xxxy = rand(1..9)
    @@xxxyy = rand(1..9)
    @@xxxyyy = rand(1..9)
  
    puts "投入コイン : #{@@bet_coin}コイン"
    puts "エンターを3回押しましょう!"
    rotate = gets
    puts "-----------------------"
    puts "|#{@@xy}|||"
    puts "|#{@@xyy}|||"
    puts "|#{@@xyyy}|||"
    rotate = gets
    puts "-----------------------"
    puts "|#{@@xy}|#{@@xxy}||"
    puts "|#{@@xyy}|#{@@xxyy}||"
    puts "|#{@@xyyy}|#{@@xxyyy}||"
    rotate = gets
    puts "-----------------------"
    puts "|#{@@xy}|#{@@xxy}|#{@@xxxy}|"
    puts "|#{@@xyy}|#{@@xxyy}|#{@@xxxyy}|"
    puts "|#{@@xyyy}|#{@@xxyyy}|#{@@xxxyyy}|"

  end

  def self.slot_result
    @temporary_coin = 0
    @temporary_point = 0
    @seven_vertical = 0
    @seven_horizontal = 0
    @seven_diagonal = 0    
    @some_vertical = 0
    @some_horizontal = 0
    @some_diagonal = 0

    #縦-----------------------
    if [@@xy,@@xyy,@@xyyy].uniq == [7]
      @seven_vertical += 1
    elsif [@@xy,@@xyy,@@xyyy].uniq.length == 1
      @some_vertical += 1
    end
    if [@@xxy,@@xxyy,@@xxyyy].uniq == [7]
      @seven_vertical += 1
    elsif [@@xxy,@@xxyy,@@xxyyy].uniq.length == 1
      @some_vertical += 1
    end
    if [@@xxxy,@@xxxyy,@@xxxyyy].uniq == [7]
      @seven_vertical += 1
    elsif [@@xxxy,@@xxxyy,@@xxxyyy].uniq.length == 1
      @some_vertical += 1
    end
    
    #横------------------------
    if [@@xy,@@xxy,@@xxxy].uniq == [7]
      @seven_horizontal += 1
    elsif [@@xy,@@xxy,@@xxxy].uniq.length == 1
      @some_horizontal += 1
    end
    if [@@xyy,@@xxyy,@@xxxyy].uniq == [7]
      @seven_horizontal += 1
    elsif [@@xyy,@@xxyy,@@xxxyy].uniq.length == 1
      @some_horizontal += 1
    end
    if [@@xyyy,@@xxyyy,@@xxxyyy].uniq == [7] 
      @seven_horizontal += 1
    elsif [@@xyyy,@@xxyyy,@@xxxyyy].uniq.length == 1
      @some_horizontal += 1
    end

    #ななめ------------------------
    if [@@xy,@@xxyy,@@xxxyyy].uniq == [7]
      @seven_diagonal += 1
    elsif [@@xy,@@xxyy,@@xxxyyy].uniq.length == 1
      @some_diagonal += 1
    end
    if [@@xxxy,@@xxyy,@@xyyy].uniq == [7]
      @seven_diagonal  += 1
    elsif [@@xxxy,@@xxyy,@@xyyy].uniq.length == 1
      @some_diagonal += 1
    end

    if @seven_vertical == 3
      puts "全て7で揃いました!!!"
      @temporary_coin += @@bet_coin * 5000
      @temporary_point += 50000
    elsif @some_vertical == 3
      puts "全て同じ数字で揃いました!!!"
      @temporary_coin += @@bet_coin * 1000
      @temporary_point += 10000
    end
    
    if (1..2).cover?(@seven_vertical)
      puts "7が縦#{@seven_vertical}列揃いました!!!"
      @temporary_coin += @@bet_coin * (@seven_vertical * 10)
      @temporary_point += 500
    end
    if (1..2).cover?(@seven_horizontal)
      puts "7が横#{@seven_horizontal}列揃いました!!!"
      @temporary_coin += @@bet_coin * (@seven_horizontal * 10)
      @temporary_point += 500
    end
    if (1..2).cover?(@seven_diagonal)
      puts "7がななめ#{@seven_diagonal}列揃いました!!!"
      @temporary_coin += @@bet_coin * (@seven_diagonal * 10)
      @temporary_point += 500
    end
    if (1..2).cover?(@some_vertical)
      puts "縦が同じ数字で#{@some_vertical}列揃いました!!!"
      @temporary_coin += @@bet_coin * (@some_vertical * 2)
      @temporary_point += 100
    end
    if (1..2).cover?(@some_horizontal)
      puts "横が同じ数字で#{@some_horizontal}列揃いました!!!"
      @temporary_coin += @@bet_coin * (@some_horizontal * 2)
      @temporary_point += 100
    end
    if (1..2).cover?(@some_diagonal)
      puts "ななめが同じ数字で#{@some_diagonal}列揃いました!!!"
      @temporary_coin += @@bet_coin * (@some_diagonal * 2)
      @temporary_point += 100
    end

    @@your_coin += @temporary_coin
    @@your_point += @temporary_point

    if @temporary_coin > 0
      puts "----------------"
      puts "#{@temporary_coin}コイン獲得!!"
      puts "#{@temporary_point}ポイント獲得!!"
      puts "----------------"
    else
      puts "はずれ"
    end

  end

end 

while true do
  puts Slot.slot_bet
  puts Slot.slot_rotate
  puts Slot.slot_result
end


