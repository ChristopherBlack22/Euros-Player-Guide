# Acting as environment

# frozen_string_literal: true

require_relative "euros_player_guide/version"
require_relative "euros_player_guide/cli"
require_relative "euros_player_guide/player"
require_relative "euros_player_guide/team"
require_relative "euros_player_guide/scraper"

module EurosPlayerGuide
  class Error < StandardError; end
end
