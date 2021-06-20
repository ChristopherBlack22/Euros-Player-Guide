require "open-uri"
require "nokogiri"
require "pry"
require_relative "team"
require_relative "player" 

class EurosPlayerGuide::Scraper

    def self.scrape_teams
        target_page = "https://www.uefa.com/uefaeuro-2020/teams/"
        doc = Nokogiri::HTML(open(target_page))

        teams = doc.css("div.team.team-is-team a").each do |team|
            name = team.attributes["title"].value
            team_url = "https://www.uefa.com#{team.attributes["href"].value}squad/"
            EurosPlayerGuide::Team.new(name, team_url)
        end 
    end 

    def self.scrape_players(url)
        target_page = url
        doc = Nokogiri::HTML(open(target_page))
        
        players = doc.css("td.squad--player-headshot a.player-name")
        players.each do |player|
            name = player.attributes["title"].value
            player_url = "https://www.uefa.com#{player.attributes["href"].value}"
            EurosPlayerGuide::Player.new(name, player_url)
        end 
    end 

    def self.scrape_stats(player)
        player_attributes = {}
        stats_page = Nokogiri::HTML(open("#{player.player_url}"))
        
        # first_name = stats_page.css("h1 span").first.text.strip
        # player_attributes[:first_name]=first_name

        # last_name = stats_page.css("h1 span").last.text.strip
        # player_attributes[:last_name]=last_name
        
        position = stats_page.css("span.player-header_category").text.strip
        player_attributes[:position]=position 
        
        club = stats_page.css("span.player-profile__data")[0].text.strip
        player_attributes[:club]=club
        
        age = stats_page.css("span.player-profile__data")[1].text.strip
        player_attributes[:age]=age 
        
        squad_number = stats_page.css("span.player-profile__data")[2].text.strip
        player_attributes[:squad_number]=squad_number 
        
        if stats_page.css("header.section--header h2").first.text.strip == "Stats"
            games_played = stats_page.css("div.statistics--list--data").text.strip[0]
            player_attributes[:games_played]=games_played

            minutes_played = stats_page.css("div.statistics--list--data").text.strip[1]
            player_attributes[:minutes_played]=minutes_played
        else
            player_attributes[:games_played]="0"
            player_attributes[:minutes_played]="0"
        end 

        player.create_attributes(player_attributes)

    end 

end 