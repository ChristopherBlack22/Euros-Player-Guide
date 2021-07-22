class EurosPlayerGuide::Player
    attr_accessor :position, :club, :age, :games_played, :minutes_played
    attr_reader :name, :number, :player_url, :team 

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