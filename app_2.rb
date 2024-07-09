require 'bundler'
Bundler.require

require_relative 'lib/player2'

puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "------------------------------------------------"

# Initialisation du joueur
puts "Quel est ton prénom ?"
print "> "
user_name = gets.chomp
user = HumanPlayer.new(user_name)

# Initialisation des ennemis
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

# Combat
while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  # Afficher l'état du joueur
  user.show_state

  # Proposer un menu d'actions
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "attaquer un joueur en vue :"
  puts "0 - #{player1.show_state}"
  puts "1 - #{player2.show_state}"
  
  # Saisie de l'utilisateur
  print "> "
  choice = gets.chomp

  # Effectuer l'action choisie
  case choice
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  when "0"
    user.attacks(player1) if player1.life_points > 0
  when "1"
    user.attacks(player2) if player2.life_points > 0
  else
    puts "Choix invalide, réessaie."
  end

  # Les ennemis ripostent
  puts "Les autres joueurs t'attaquent !"
  enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    end
  end
end

# Fin du jeu
puts "La partie est finie"
if user.life_points > 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end
