class EurosPlayerGuide::CLI
    #attr_accessor :input

    def call
        puts "Welcome to the Euro 2020 Player Guide, your quick source of key player stats."
        create_teams
        list_teams
        select_team
        select_player
        puts "Goodbye."
    end 


    def create_teams
        EurosPlayerGuide::Scraper.scrape_teams
    end 

    def list_teams
        #EurosPlayerGuide::Scraper.scrape_teams
        puts "Here are the teams competing at Euro 2020:"
        @teams = EurosPlayerGuide::Team.all
        @teams.each.with_index(1) do |team, index|
            puts "#{index}. #{team.name}"
        end 
    end 

    def select_team
        @input = nil       
        until @input == "exit" || @input == "valid team"
            puts "Please type the number of the team you would like to view, or type 'exit' to close."
            @input = gets.strip.downcase    
            
            if valid_input?(@input, @teams)
                team = @teams[(@input.to_i)-1] 
                #binding.pry 
                create_players(team)
                list_players 
                @input = "valid team"
                
            elsif @input == "exit" 

            else
                puts "Sorry, your selection did not match the available options."
            end
        end 
        
    end 

    def valid_input?(input, data)
        input.to_i > 0 && input.to_i <= data.count
    end 


    def create_players(team)
        EurosPlayerGuide::Scraper.scrape_players(team)
        players = team.players
        @sorted_players = players.sort{|a,b| a.number.to_i <=> b.number.to_i}
    end 

    def list_players#(team)
        # EurosPlayerGuide::Scraper.scrape_players(team)
        # @players = team.players
        
 #binding.pry
        # puts "Here is the squad of #{team.name}"
        puts "here is the squad for #{@sorted_players.first.team.name}"
        

        @sorted_players.each.with_index(1) do |player, index|
            puts "#{index}. #{player.name}"
        end 

    end 

    def select_player
        if @input != "exit"
            @input = nil #reset @input to nil other "exit" will bypass this method and end program
        end 
        until @input == "exit" 
            puts "Please select the number of the player you are interested in, or 'teams' or 'exit'." #type teams to return to list, or exit
            @input = gets.strip.downcase
            if valid_input?(@input, @sorted_players)
                player = @sorted_players[(@input.to_i)-1] 
                EurosPlayerGuide::Scraper.scrape_stats(player)
                puts "Name - #{player.name}"
                puts "Squad Number - #{player.number}"
                puts "Position - #{player.position}"
                puts "Age - #{player.age}"
                puts "Domestic Club - #{player.club}"
                if player.games_played != "0"
                    puts "Has played a total of #{player.minutes_played} minutes over #{player.games_played} game/s at Euro 2020."
                else
                    puts "Is yet to play at Euro 2020."
                end

                puts "Type 'players', 'teams' or 'exit'"
                @input = gets.strip.downcase
                if @input == "players"
                    list_players 
                    select_player
                elsif @input == "teams"
                    list_teams
                    select_team
                elsif @input == "exit"

                else 
                    "Sorry sausage fingers try again"
                end 

            elsif @input == "teams"
                list_teams
                select_team
            elsif @input == "exit"

            else
                puts "Sorry, your selection did not match the available options."
                
            end 
        end 
        
    end 


end 