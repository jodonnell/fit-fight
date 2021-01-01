class Fight
  def initialize player1, player2
    @player1 = player1
    @player2 = player2
    @output = []
  end

  def self.default_vars
    {
      min_damage: 5,
      max_damage: 10,
      min_block: 0,
      max_block: 5,
      name: '',
      hp: 40,
      has_evaded: false,
      exercises: {
        'Push Ups' => 0,
        'Squats' => 0,
        'Planks' => 0,
        'Running' => 0,
        'Rowing' => 0,
        'Curls' => 0,
        'Shoulder Press' => 0,
      }
    }
  end

  def fight
    intro @player1
    intro @player2
    newline

    heal @player1
    heal @player2
    newline

    attack @player1, @player2
    attack @player2, @player1

    p1_dead = player_dead?(@player1)
    p2_dead = player_dead?(@player2)
    newline

    is_over?

    @output
  end

  def attack attacker, defender
    ap = attack_power attacker
    bp = block_power defender

    critical_hit = critical_damage? attacker
    if critical_hit
      ap *= critical_damage_multiplier attacker
    end

    did_evade = evaded? defender

    damage = (ap - bp)
    defender[:hp] = defender[:hp] - damage unless did_evade

    @output.push("#{attacker[:name]} attacked for #{ap.round} damage")

    if critical_hit
      @output.push("#{attacker[:name]} just SLAMMED #{defender[:name]}")
    end

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
    min_attack = player[:min_damage] * (1 + player[:exercises]['Push Ups'] / 100.0)
    max_attack = player[:max_damage] * (1 + player[:exercises]['Push Ups'] / 100.0)
    rand(min_attack...max_attack)
  end

  def block_power player
    min_block = player[:min_block] * (1 + player[:exercises]['Squats'] / 100.0)
    max_block = player[:max_block] * (1 + player[:exercises]['Squats'] / 100.0)
    rand(min_block...max_block)
  end

  def evaded? player
    return false if player[:has_evaded]
    chance = [player[:exercises]['Planks'] * 4, 20].min
    has_evaded = rand(0...100) < chance

    player[:has_evaded] = true if has_evaded
    return has_evaded
  end

  def critical_damage? player
    chance = player[:exercises]['Curls'] / 100.0
    return rand(0...100) < chance
  end

  def critical_damage_multiplier player
    chance = player[:exercises]['Shoulder Press'] / 1000.0
    2 + chance
  end

  def player_dead? player
    dead = player[:hp] <= 0
    if dead
      @output.push("#{player[:name]} is dead")
    end
    dead
  end

  def intro player
    results = []
    player[:exercises].keys.each do |exercise|
      results.push("#{player[:exercises][exercise]} #{exercise}")
    end
    @output.push("#{player[:name]} did " + results.join(', '))
  end

  def newline
    @output.push("")
  end

  def heal player
    running_heal = player[:exercises]['Running'] / 2
    rowing_heal = player[:exercises]['Rowing'] / 2

    total_heal = running_heal + rowing_heal
    player[:hp] += total_heal
    if total_heal > 0
      @output.push("#{player[:name]} healed #{total_heal} health and now has #{player[:hp]} life")
    end
  end

  def is_over?
    @player1[:fighter].hp = @player1[:hp]
    @player2[:fighter].hp = @player2[:hp]

    killed_each_other = @player1[:hp] < 0 && @player2[:hp] < 0
    player1_dead = @player1[:hp] < 0
    player2_dead = @player2[:hp] < 0

    if killed_each_other or player1_dead or player2_dead
      @player1[:fighter].hp = 40
      @player2[:fighter].hp = 40
    end

    if killed_each_other
      @output.push("The mighty titans die in each others arms.  Farewell sweet princes.")
      @player1[:fighter].wins += 1
      @player2[:fighter].wins += 1
    else
      if player1_dead
        @output.push("#{@player2[:name]} is victorious, he pees over #{@player1[:name]}'s corpse.")
        @player2[:fighter].wins += 1
      end

      if player2_dead
        @output.push("#{@player1[:name]} is victorious, he pees over #{@player2[:name]}'s corpse.")
        @player1[:fighter].wins += 1
      end
    end

    @player1[:fighter].save
    @player2[:fighter].save
  end
end
