class Fight
  def initialize player1, player2
    @player1 = player1
    @player2 = player2
    @output = []
  end

  def fight
    intro @player1
    intro @player2
    newline

    5.times do |round|
      @output.push "Round #{round + 1}"

      attack @player1, @player2
      attack @player2, @player1

      p1_dead = player_dead?(@player1)
      p2_dead = player_dead?(@player2)
      break if p1_dead || p2_dead
      newline
    end

    if (@player1[:hp] > @player2[:hp]) && @player1[:hp] > 0
      @output.push("#{@player1[:name]} wins")
    end

    if (@player2[:hp] > @player1[:hp]) && @player2[:hp] > 0
      @output.push("#{@player2[:name]} wins")
    end

    @output
  end

  def attack attacker, defender
    ap = attack_power attacker
    bp = block_power defender

    did_evade = evaded? defender

    damage = (ap - bp)
    defender[:hp] = defender[:hp] - damage unless did_evade

    @output.push("#{attacker[:name]} attacked for #{ap.round} damage")
    if did_evade
      @output.push("#{defender[:name]} swiftly dodged the attack")
    else
      @output.push("#{defender[:name]} blocked #{bp.round} damage")
      @output.push("#{defender[:name]} took #{damage.round} damage")
      @output.push("#{defender[:name]} has #{defender[:hp].round} life left")
    end
    @output.push("")
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

  def evaded? player
    return false if player[:has_evaded]
    chance = [player[:planks] * 4, 20].min
    has_evaded = rand(0...100) < chance

    player[:has_evaded] = true if has_evaded
    return has_evaded
  end

  def player_dead? player
    dead = player[:hp] <= 0
    if dead
      @output.push("#{player[:name]} is dead")
    end
    dead
  end

  def intro player
    @output.push("#{player[:name]} did #{player[:pushups]} pushups, #{player[:squats]} squats, #{player[:planks]} minutes of planks")
  end

  def newline
    @output.push("")
  end
end
