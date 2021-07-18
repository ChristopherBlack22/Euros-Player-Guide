class EurosPlayerGuide::CLI

    def call
        puts "\n--  -- Welcome to the Euro 2020 Player Guide --  --\n  --  --      Up-to-date player stats      --  --   "
        create_teams
        list_teams
        make_selections
        puts "\nThank you for using the Euro 2020 Player Guide.\n--- -- -- Goodbye -- -- ---"
    end 


    def valid_input?(input, data)
        input.to_i > 0 && input.to_i <= data.count
    end 

    def create_teams
        EurosPlayerGuide::Scraper.scrape_teams
    end 

    def list_teams
        puts "\nThe teams competing at Euro 2020 are:"
        @teams = EurosPlayerGuide::Team.all
        @teams.each.with_index(1) do |team, index|
            puts "#{index}. #{team.name}"
        end 
    end 

    def make_selections
        @input = nil       
        until @input == "exit"
            puts "Please select a team by typing the corresponding number, or type 'exit' to leave."
            @input = gets.strip.downcase    
            
            if valid_input?(@input, @teams)
                team = @teams[(@input.to_i)-1] 
                create_players(team) if team.players == []
                list_players 
                select_player 
            elsif @input == "exit" 

            else
                puts "\nSorry, you do seem to have typed a valid option."
            end
        end 
    end

    def create_players(team)
        EurosPlayerGuide::Scraper.scrape_players(team)
        players = team.players
        @sorted_players = players.sort{|a,b| a.number.to_i <=> b.number.to_i}
    end 

    def list_players
        puts "\nThe players from #{@sorted_players.first.team.name} at Euro 2020 are:"
        @sorted_players.each.with_index(1) do |player, index|
            puts "#{index}. #{player.name}"
        end 
    end 

    def select_player
        @input = nil 
        until @input == "exit"
            puts "Please select a player by typing their squad number, or type 'teams' to select a different team, or 'exit' to leave."
            @input = gets.strip.downcase
            if valid_input?(@input, @sorted_players)
                player = @sorted_players[(@input.to_i)-1] 
                EurosPlayerGuide::Scraper.scrape_stats(player)
                puts "\n#{player.name} - #{player.team.name}"
                puts "Squad Number - #{player.number}"
                puts "Position - #{player.position}"
                puts "Age - #{player.age}"
                puts "Domestic Club - #{player.club}"
                if player.games_played != "0"
                    puts "Has played a total of #{player.minutes_played} minutes over #{player.games_played} game/s at Euro 2020 for #{player.team.name}."
                else
                    puts "Has not played at Euro 2020."
                end
                make_new_selections
            elsif @input == "teams"
                list_teams
                make_selections
            elsif @input == "exit"

            else
                puts "\nSorry, you do not seem to have typed a valid option."    
            end 
        end   
    end 

    def make_new_selections
        @input = nil 
        until @input == "exit"
            puts "\nWhat would you like to do now?"
            puts "Type 'players' to select another player from #{@sorted_players.first.team.name}, 'teams' to select a different team, or 'exit' to leave."
            @input = gets.strip.downcase
            if @input == "players"
                list_players 
                select_player
            elsif @input == "teams"
                list_teams
                make_selections
            elsif @input == "exit"

            else 
                puts "\nSorry, you do not seem to have typed a valid option."
            end 
        end 
    end

end 