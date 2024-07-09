require_relative 'player'
require_relative 'player2'


class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(human_player_name)
    @human_player = HumanPlayer.new(human_player_name)
    @enemies_in_sight = []
    @players_left = 10
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && @players_left > 0
  end

  def show_players
    @human_player.show_state
    puts "Il reste #{@enemies_in_sight.size} ennemis en vue et #{@players_left} ennemis au total."
  end

  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "attaquer un joueur en vue :"
    @enemies_in_sight.each_with_index do |enemy, index|
      puts "#{index} - #{enemy.show_state}"
    end
  end

  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon
    when "s"
      @human_player.search_health_pack
    else
      if choice.to_i.between?(0, @enemies_in_sight.size - 1)
        @human_player.attacks(@enemies_in_sight[choice.to_i])
        kill_player(@enemies_in_sight[choice.to_i]) if @enemies_in_sight[choice.to_i].life_points <= 0
      else
        puts "Choix invalide, réessaie."
      end
    end
  end

  def enemies_attack
    @enemies_in_sight.each do |enemy|
      enemy.attacks(@human_player) if enemy.life_points > 0
    end
  end

  def end
    puts "La partie est finie"
    if @human_player.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end

  def new_players_in_sight
    if @enemies_in_sight.size == @players_left
      puts "Tous les joueurs sont déjà en vue."
      return
    end

    dice_roll = rand(1..6)
    case dice_roll
    when 1
      puts "Aucun nouveau joueur adverse n'arrive."
    when 2..4
      new_enemy = Player.new("joueur_#{rand(1000..9999)}")
      @enemies_in_sight << new_enemy
      puts "Un nouvel adversaire arrive en vue : #{new_enemy.name}."
    when 5..6
      2.times do
        break if @enemies_in_sight.size == @players_left
        new_enemy = Player.new("joueur_#{rand(1000..9999)}")
        @enemies_in_sight << new_enemy
        puts "Deux nouveaux adversaires arrivent en vue : #{new_enemy.name}."
      end
    end
  end
end
