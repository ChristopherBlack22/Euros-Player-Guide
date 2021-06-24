class EurosPlayerGuide::Player
    attr_accessor :name, :number, :player_url, :team, :position, :club, :age, :games_played, :minutes_played 

    def initialize(name, number, player_url, team)
        @name = name
        @number = number
        @player_url = player_url
        @team = team 
        team.players << self 
    end 
        
    def create_attributes(player_attributes)
        player_attributes.each {|k, v| self.send(("#{k}="),v)}
    end 

end 