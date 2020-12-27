class Fight
  def initialize player1, player2
    @player1 = player1
    @player2 = player2
  end

  def fight
    output = []
    5.times do |round|
      output.push "Round #{round + 1}"

      attack @player1, @player2, output
      attack @player2, @player1, output

      p1_dead = player_dead?(@player1, output)
      p2_dead = player_dead?(@player2, output)
      break if p1_dead || p2_dead
    end

    if (@player1[:hp] > @player2[:hp]) && @player1[:hp] > 0
      output.push("#{@player1[:name]} wins")
    end

    if (@player2[:hp] > @player1[:hp]) && @player2[:hp] > 0
      output.push("#{@player2[:name]} wins")
    end

    output
  end

  def attack attacker, defender, output
      ap = attack_power attacker
      bp = block_power defender

      damage = (ap - bp)
      defender[:hp] = defender[:hp] - damage

      output.push("#{attacker[:name]} attacked for #{ap.round} damage")
      output.push("#{defender[:name]} blocked #{bp.round} damage")
      output.push("#{defender[:name]} took #{damage.round} damage")
      output.push("#{defender[:name]} has #{defender[:hp].round} life left")
      output.push("")
  end

  def attack_power player
      min_attack = player[:min_damage] * (1 + player[:pushups] / 100.0)
      max_attack = player[:max_damage] * (1 + player[:pushups] / 100.0)
      rand(min_attack...max_attack)
  end

  def block_power player
      min_block = player[:min_block] * (1 + player[:squats] / 100.0)
      max_block = player[:max_block] * (1 + player[:squats] / 100.0)
      rand(min_block...max_block)
  end

  def player_dead? player, output
    dead = player[:hp] <= 0
    if dead
      output.push("#{player[:name]} is dead")
    end
    dead
  end
end
