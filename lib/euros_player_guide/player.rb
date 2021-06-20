class EurosPlayerGuide::Player
    attr_accessor :name, :player_url, :position, :club, :age, :squad_number, :games_played, :minutes_played 

    @@all = []

    def initialize(name, player_url)
        @name = name
        @player_url = player_url
        save
    end 
        
    def create_attributes(player_attributes)
        player_attributes.each {|k, v| self.send(("#{k}="),v)}
    end 

    def save
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.reset_all
        @@all.clear
    end 

end 