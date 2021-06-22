require "pry"

class EurosPlayerGuide::Player
    attr_accessor :name, :number, :player_url, :team, :position, :club, :age, :games_played, :minutes_played 

    @@all = []

    def initialize(name, number, player_url, team)
         
        @name = name
        @number = number
        @player_url = player_url
        @team = team #new line
        team.players << self #new line
        #binding.pry 
        #save
    end 
      #binding.pry   
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