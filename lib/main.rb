require 'rest-client'
require 'json'

require_relative 'config'
require_relative 'types'

# @author Wesley A F Gomes
# Main module for the FFlogsAPI gem
module FFlogs

  # Module that represents the API category Zones
  module Zones
    # Gets an array of Zone objects. Each zone corresponds to a raid/dungeon instance in the game and has its own set of encounters.
    #
    # @return [FFlogs::Type::Zone]
    def self.zones()
      result = FFlogs.call("zones")

      output = []
      for entry in result

        output.push(Type::Zone.new(entry))
      end
      return output
    end
  end

  # Module that represents the API category Classes
  module Classes
    # Gets an array of Class objects. Each Class corresponds to a class in the game.
    #
    # @return [FFlogs::Type::Classes]
    def self.classes()
      result = FFlogs.call("classes")

      output = []
      for entry in result
        output.push(Type::Class.new(entry))
      end
      return output
    end
  end

  # Module that represents the API category Rankings
  module Rankings
    # Gets an object that contains a total count and an array of EncounterRanking objects and a total number of rankings for that encounter.
    # Each EncounterRanking corresponds to a single character or guild/team.
    # @note Optional parameters can be passed as keyword arguments. A list of parameters can be found at https://www.fflogs.com/v1/docs/
    #
    # @param encounterID [Numeric] The encounter to collect rankings for. Encounter IDs can be obtained using a /zones request
    # @return [FFlogs::Type::EncounterRankings]
    def self.encounter(encounterID:, **params)
      result = FFlogs.call("rankings/encounter/#{encounterID}", params)

      output = Type::EncounterRankings.new(result)
      return output
    end

    # Gets an array of CharacterRanking objects. Each CharacterRanking corresponds to a single rank on a fight for the specified character.
    #
    # @note (see FFlogs::Rankings.encounter)
    # @param characterName [String] The name of the character to collect rankings for.
    # @param serverName [String] The server that the character is found on.
    # @param serverRegion [String] The short region name for the server on which the character is located: NA, EU, JP.
    # @return [Array<FFlogs::Type::CharacterRanking>]
    def self.character(characterName:, serverName:, serverRegion:, **params)
      result = FFlogs.call("rankings/character/#{URI.escape(characterName)}/#{URI.escape(serverName)}/#{URI.escape(serverRegion)}", params)

      output = []
      for entry in result
        output.push(Type::CharacterRanking.new(entry))
      end
      return output
    end
  end

  # Module that represents the API category Parses
  module Parses
    # Obtains all parses for a character in the zone across all specs. Every parse is included and not just rankings.
    #
    # @note (see FFlogs::Rankings.encounter)
    # @param characterName [String] The name of the character to collect rankings for.
    # @param serverName [String] The server that the character is found on.
    # @param serverRegion [String]: The short region name for the server on which the character is located: NA, EU, JP.
    # @return [FFlogs::Type::Parse]
    def self.character(characterName:, serverName:, serverRegion:, **params)
      result = FFlogs.call("parses/character/#{URI.escape(characterName)}/#{URI.escape(serverName)}/#{URI.escape(serverRegion)}", params)

      output = []
      for entry in result
        output.push(Type::Parse.new(entry))
      end
      return output
    end
  end

  # Module that represents the API category Reports
  module Reports
    # Gets an array of Report objects. Each Report corresponds to a single calendar report for the specified guild.
    #
    # @note (see FFlogs::Rankings.encounter)
    # @param guildName [String] The name of the guild to collect reports for.
    # @param serverName [String] The server that the character is found on.
    # @param serverRegion [String] The short region name for the server on which the character is located: NA, EU, JP.
    # @return [FFlogs::Type::Report]
    def self.guild(guildName:, serverName:, serverRegion:, **params)
      result = FFlogs.call("reports/guild/#{URI.escape(guildName)}/#{URI.escape(serverName)}/#{URI.escape(serverRegion)}", params)

      output = []
      for entry in result
        output.push(Type::Report.new(entry))
      end
      return output
    end

    # Gets an array of Report objects. Each Report corresponds to a single calendar report for the specified user's personal logs.
    #
    # @note (see FFlogs::Rankings.encounter)
    # @param username [String] The name of the user to collect reports for.
    # @return [FFlogs::Type::Report]
    def self.user(username:, **params)
      result = FFlogs.call("reports/user/#{URI.escape(username)}", params)

      output = []
      for entry in result
        output.push(Type::Report.new(entry))
      end
      return output
    end
  end

  # Module that represents the API category Report
  module Report

    # TODO: Add conversion of Arrays and Hash to Custom Objects, someday


    # Gets arrays of fights and the participants in those fights. Each Fight corresponds to a single pull of a boss.
    # @note (see FFlogs::Rankings.encounter)
    #
    # @param code [String] The specific report to collect fights and participants for.
    # @return [Array<Hash>]
    def self.fights(code:, **params)
      FFlogs.call("report/fights/#{URI.escape(code)}", params)
    end

    # Gets an array of events, such as damage, healing, cast, buff and debuff events. A maximum of 300 events will be returned from this API call.
    # A nextPageTimestamp field will be included in the return result, and you can issue another query with that as the new start to keep fetching events.
    # @note (see FFlogs::Rankings.encounter)
    #
    # @param code [String] The specific report to collect events for.
    # @return [Array<Hash>]
    def self.events(code:, **params)
      FFlogs.call("report/events/#{URI.escape(code)}", params)
    end

    # Gets a table of entries, either by actor or ability, of damage, healing and cast totals for each entry.
    # @note This API exactly follows what is returned for the Tables panes on the site. It can and will change as the needs of those panes do, and as such should never be considered a frozen API. Use at your own risk.
    # @note (see FFlogs::Rankings.encounter)
    #
    # @param code [String] The specific report to collect events for.
    # @return [Array<Hash>]
    def self.tables(view:, code:, **params)
      FFlogs.call("report/tables/#{URI.escape(view)}/#{URI.escape(code)}", params)
    end
  end

  private
  def self.call(function, **args)
    params = "?api_key=#{PUBLIC_KEY}"
    for key, val in args
      params += "&#{URI.escape(key.to_s)}=#{URI.escape(val.to_s)}"
    end

    result = RestClient.get("#{API_URL}#{function}#{params}")
    return JSON.parse(result)
  end
end
