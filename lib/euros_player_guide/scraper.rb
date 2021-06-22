require "open-uri"
require "nokogiri"
require "pry"
require_relative "team"
require_relative "player" 

class EurosPlayerGuide::Scraper

    def self.scrape_teams
        teams_page = "https://www.uefa.com/uefaeuro-2020/teams/"
        doc = Nokogiri::HTML(open(teams_page))

        teams = doc.css("div.team.team-is-team a").each do |team|
            name = team.attributes["title"].value
            team_url = "https://www.uefa.com#{team.attributes["href"].value}squad/"
            EurosPlayerGuide::Team.new(name, team_url)
        end 
    end 

    def self.scrape_players(team) #changed from url to team
        target_page = team.team_url 
        #target_page = url
        doc = Nokogiri::HTML(open(target_page))
        
        players = doc.css("td.squad--player-headshot a.player-name")
        players.each do |player|
            name = player.attributes["title"].value
            number = player.text.sub("#{name} ","").sub("(","").sub(")","").strip
            player_url = "https://www.uefa.com#{player.attributes["href"].value}".sub("æ", "ae")
            #binding.pry 
            EurosPlayerGuide::Player.new(name, number, player_url, team) #added team
        end 
    end 

    def self.scrape_stats(player)
        player_attributes = {}
        stats_page = Nokogiri::HTML(open("#{player.player_url}"))
        
        position = stats_page.css("span.player-header_category").text.strip
        player_attributes[:position]=position 
        
        club = stats_page.css("span.player-profile__data")[0].text.strip
        player_attributes[:club]=club
        
        age = stats_page.css("span.player-profile__data")[1].text.strip
        player_attributes[:age]=age 
        
        
        if stats_page.css("header.section--header h2").first.text.strip == "Stats"
            games_played = stats_page.css("div.field-xs-small div")[0].text.strip
            player_attributes[:games_played]=games_played
            
            minutes_played = stats_page.css("div.field-xs-small div")[1].text.strip.sub("'","")
            player_attributes[:minutes_played]=minutes_played
        else
            player_attributes[:games_played]="0"
            player_attributes[:minutes_played]="0"
        end 

        player.create_attributes(player_attributes)

    end 

end 