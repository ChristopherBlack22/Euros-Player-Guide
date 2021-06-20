class EurosPlayerGuide::CLI

    def call
        puts "Welcome to the Euro 2020 Player Guide, your quick source of key player stats."
        get_teams
        list_teams
        select_team
       
        #lists players of selected team scraped from team webpage
        #requests an input
        #takes an input
        #list player attributes scraped from player webpage

    end 

    def get_teams
        EurosPlayerGuide::Scraper.scrape_teams
        @teams = EurosPlayerGuide::Team.all
    end 
    
    def list_teams
        puts "Here are the teams competing at Euro 2020:"
        @teams.each.with_index(1) do |team, index|
            puts "#{index}. #{team.name}"
        end 
    end 

    def select_team
        puts "Please type the number of the team whose squad you would like to view, or type 'exit' to close."
        input = gets.strip.downcase
        if valid_input?(input, @teams)
            team = @teams[(input.to_i)-1] 
            
            get_players(team)
            list_players(team)
            select_player
        elsif input == "exit"
            puts "Thanks for using the Euros Player Guide. Please come back again. Goodbye."
        else
            puts "Sorry, your selection did not match the available options."
            select_team
        end
    end 

    def valid_input?(input, data) #2nd argument of data, so that can be used again when selecting a player?
        input.to_i > 0 && input.to_i <= data.count
    end 

    def get_players(team)
        EurosPlayerGuide::Scraper.scrape_players("#{team.team_url}")
        @players = EurosPlayerGuide::Player.all
    end 

    def list_players(team)
        puts "Here is the squad of #{team.name}"

        @players.each.with_index(1) do |player, index|
            puts "#{index}. #{player.name}"
        end 
        
    end 

    def select_player
        puts "Please select the number of the player you are interested in." #type teams to return to list, or exit
        input = gets.strip.downcase
        if valid_input?(input, @players)
            player = @players[(input.to_i)-1] 
            EurosPlayerGuide::Scraper.scrape_stats(player)
            puts "Name - #{player.name}"
            puts "Shirt Number - #{player.squad_number}"
            puts "Position - #{player.position}"
            puts "Age - #{player.age}"
            puts "Domestic Club - #{player.club}"
            if player.games_played != "0"
                puts "Has played #{player.minutes_played} across #{player.games_played} at Euro 2020."
            else
                puts "Has yet to play at Euro 2020."
            end 
        else
            puts "Sorry, your selection did not match the available options."
            select_player
        end 
    end 

end 