class EurosPlayerGuide::Team
    attr_accessor :name, :team_url

    @@all = []

    def initialize(name, team_url)
        @name = name
        @team_url = team_url 
        save 
    end 

    def save
        @@all << self
    end 

    def self.all
        @@all 
    end 

end 