require 'bundler'
Bundler.require


require_relative 'lib/player'


# Créer les joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")

# Boucle de combat jusqu'à ce qu'un des joueurs soit mort
while player1.life_points > 0 && player2.life_points > 0
  # Afficher l'état des joueurs
  puts "\nVoici l'état de chaque joueur :"
  player1.show_state
  player2.show_state

  # Phase d'attaque
  puts "\nPassons à la phase d'attaque :"
  player1.attacks(player2)
  break if player2.life_points <= 0 # Vérifier si player2 est mort

  player2.attacks(player1)
end

binding.pry
