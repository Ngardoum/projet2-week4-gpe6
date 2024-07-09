

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


class HumanPlayer < Player
    attr_accessor :weapon_level
  
    def initialize(name)
      super(name)
      @life_points = 100
      @weapon_level = 1
    end
  
    def show_state
      puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    end
  
    def compute_damage
      rand(1..6) * @weapon_level
    end
  
    def search_weapon
      new_weapon_level = rand(1..6)
      puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
      if new_weapon_level > @weapon_level
        @weapon_level = new_weapon_level
        puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      else
        puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
      end
    end
  
    def search_health_pack
      dice_roll = rand(1..6)
      if dice_roll == 1
        puts "Tu n'as rien trouvé..."
      elsif dice_roll.between?(2, 5)
        @life_points = [@life_points + 50, 100].min
        puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      elsif dice_roll == 6
        @life_points = [@life_points + 80, 100].min
        puts "Waow, tu as trouvé un pack de +80 points de vie !"
      end
    end
  end