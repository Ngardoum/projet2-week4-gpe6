
class Player
    attr_accessor :name, :life_points
  
    def initialize (name)
        @name = name
        @life_points = 10
    end    

    def show_state
        puts "#{@name} a #{@life_points} points de vie"
    end    

    def gets_damage(damage)
        @life_points -= damage
        if @life_points <= 0
            @life_points = 0
            puts "le joueur #{@name} a ete tué!"
        end
    end

    def attacks(player)
        puts "#{@name} attaque #{player.name}"
        damage = compute_damage
        puts "il lui inflige #{damage} points de dommages"
        player.gets_damage(damage)
      end
    
      def compute_damage
        rand(1..6)
      end
    
end    