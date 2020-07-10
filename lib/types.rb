module FFlogs
  # Module that houses the types returned by the FFlogsAPI
  module Type

    # Corresponds to a group of raid/dungeon instances in the game
    class Zone
      # A unique identifier representing this specific zone.
      # @return [Numeric]
      attr_reader :id

      # The English name of the raid zone.
      # @return [String]
      attr_reader :name

      # Whether or not the rankings and statistics for the zone are frozen.
      # If set, then the results for this zone are never going to change, and you don't have to fetch them again.
      # @return [Boolean]
      attr_reader :frozen

      # The encounters for this zone.
      # @return [Array<Encounter>]
      attr_reader :encounters

      # The brackets for this zone.
      # Rankings and statistics are collected for each bracket.
      # @return [Array<Bracket>]
      attr_reader :brackets

      def initialize(hash)
        @id = hash['id']
        @name = hash['name']
        @frozen = hash['frozen']

        @encounters = []
        for encounter in hash['encounters']
          @encounters.push(Encounter.new(encounter))
        end

        @brackets = []
        for bracket in hash['brackets']
          @brackets.push(Bracket.new(bracket))
        end
      end
    end
    # Generic info about a raid/dungeon
    class Encounter
      # A unique identifier representing this specific encounter.
      # @return [Numeric]
      attr_reader :id

      # The English name of the encounter.
      # @return [String]
      attr_reader :name

      def initialize(hash)
        @id = hash['id']
        @name = hash['name']
      end
    end
    # Generic info about a category of raids/dungeons
    class Bracket
      # A unique identifier representing this specific rankings bracket.
      # @return [Numeric]
      attr_reader :id

      # An explanation of what the bracket contains.
      # @return [String]
      attr_reader :name

      def initialize(hash)
        @id = hash['id']
        @name = hash['name']
      end
    end

    # Corresponds to a class in the game.
    class Class
      # A unique identifier representing this specific class.
      # @return [Numeric]
      attr_reader :id

      # The English name of the class.
      # @return [String]
      attr_reader :name

      # The possible specs for this class.
      # @return [Array<Spec>]
      attr_reader :specs

      def initialize(hash)
        @id = hash['id']
        @name = hash['name']
        @specs = []
        for spec in hash['specs']
          @specs.push(Spec.new(spec))
        end
      end
    end
    # A spec belonging to a class
    class Spec
      # A unique identifier representing this specific spec.
      # @return [Numeric]
      attr_reader :id

      # The English name of the spec.
      # @return [String]
      attr_reader :name

      def initialize(hash)
        @id = hash['id']
        @name = hash['name']
      end
    end

    # A group of EncounterRanking classes and a counter
    class EncounterRankings
      # The total number of rankings given the specified filters.
      # @return [Numeric]
      attr_reader :total

      # An array of EncounterRanking objects.
      # @return [Array<EncounterRanking>]
      attr_reader :rankings

      def initialize(hash)
        @total = hash['total']
        @rankings = []
        for ranking in hash['rankings']
          @rankings.push(EncounterRanking.new(ranking))
        end
      end

    end
    # Ranking info of a single character or guild/team.
    class EncounterRanking
      # The name of the character that obtained the ranking.
      # @return [String]
      attr_reader :name

      # For individual rankings, the DPS/HPS value.
      # @return [Decimal]
      attr_reader :total

      # For individual rankings, the class of the character.
      # @return [String]
      attr_reader :class

      # For individual rankings, the spec of the character.
      # @return [Numeric]
      attr_reader :spec

      # The name of the guild that obtained the ranking.
      # @return [Numeric]
      attr_reader :guild

      # The server that the ranking was obtained on.
      # @return [String]
      attr_reader :server

      # The short name of the region that the server belongs to.
      # @return [String]
      attr_reader :region

      # The length of the fight/run in milliseconds.
      # @return [String]
      attr_reader :duration

      # A timestamp with millisecond precision that indicates when the fight/run happened.
      # @return [Decimal]
      attr_reader :startTime

      # For fight rankings, how much damage was taken over the course of the fight.
      # @return [Decimal]
      attr_reader :damageTaken

      # For fight rankings, how much people died on the fight.
      # @return [Decimal]
      attr_reader :deaths

      # For fight rankings, the average item level of the raid. For character rankings, the item level of the character.
      # @return [Decimal]
      attr_reader :itemLevel

      # For challenge mode rankings, what patch they were obtained in.
      # @return [Decimal]
      attr_reader :patch

      # The report ID that contains this ranking.
      # @return [String]
      attr_reader :reportID

      # The fight ID within the report for the fight that contains this ranking.
      # @return [Decimal]
      attr_reader :fightID

      # For challenge mode rankings, the team members that made up the team.
      # @return [Array<TeamMember>]
      attr_reader :team

      # The size of the raid. Only set for flexible size raids. Remember that flexible raid sizes are all ranked together currently.
      # @return [Numeric]
      attr_reader :size

      def initialize(hash)
        @name = hash['name']
        @total = hash['total']
        @class = hash['class']
        @spec = hash['spec']
        @guild = hash['guild']
        @server = hash['server']
        @region = hash['region']
        @duration = hash['duration']
        @startTime = hash['startTime']
        @damageTaken = hash['damageTaken']
        @deaths = hash['deaths']
        @itemLevel = hash['itemLevel']
        @patch = hash['patch']
        @reportID = hash['reportID']
        @fightID = hash['fightID']
        @size = hash['size']

        if(hash['team'].nil?)
          @team = nil
        else
          @team = []
          for member in hash['team']
            @team.push(TeamMember.new(member))
          end
        end
      end
    end
    # Basic info of a member of a team
    class TeamMember
      # The name of the character on the team.
      # @return [String]
      attr_reader :name

      # The class of the character on the team.
      # @return [Numeric]
      attr_reader :class

      # The spec of the character on the team.
      # @return [Numeric]
      attr_reader :spec

      def initialize(hash)
        @name = hash['name']
        @class = hash['class']
        @spec = hash['spec']
      end
    end

    # Corresponds to a single rank on a fight for a character
    class CharacterRanking
      attr_reader :rank
      attr_reader :outOf
      attr_reader :total
      attr_reader :class
      attr_reader :spec
      attr_reader :guild
      attr_reader :duration
      attr_reader :startTime
      attr_reader :itemLevel
      attr_reader :patch
      attr_reader :reportID
      attr_reader :fightID
      attr_reader :difficulty
      attr_reader :size
      attr_reader :estimate
      attr_reader :encounter

      def initialize(hash)
        @rank = hash['rank']
        @outOf = hash['outOf']
        @total = hash['total']
        @class = hash['class']
        @spec = hash['spec']
        @guild = hash['guild']
        @duration = hash['duration']
        @startTime = hash['startTime']
        @itemLevel = hash['itemLevel']
        @report = hash['reportID']
        @fightID = hash['fightID']
        @difficulty = hash['difficulty']
        @size = hash['size']
        @estimate = hash['estimate']
        @encounter = hash['encounter']
      end
    end

    # General parse info for a character
    class Parse
      attr_reader :difficulty
      attr_reader :size
      attr_reader :kill
      attr_reader :name
      attr_reader :specs

      def initialize(hash)
        @difficulty = hash['difficulty']
        @size = hash['size']
        @kill = hash['kill']
        @name = hash['name']

        @specs = []
        for spec in hash['specs']
          @specs.push(ParseSpec.new(spec))
        end
      end
    end
    # Parse info for a character for a specific spec
    class ParseSpec
      attr_reader :class
      attr_reader :spec
      attr_reader :combined
      attr_reader :data
      attr_reader :best_persecondamount
      attr_reader :best_duration
      attr_reader :best_historical_percent
      attr_reader :best_allstar_points
      attr_reader :best_combined_allstar_points
      attr_reader :possible_allstar_points
      attr_reader :historical_total
      attr_reader :historical_median
      attr_reader :historical_avg

      def initialize(hash)
        @class = hash['class']
        @spec = hash['spec']
        @combined = hash['combined']
        @best_persecondamount = hash['best_persecondamount']
        @best_duration = hash['best_duration']
        @best_historical_percent = hash['best_historical_percent']
        @best_allstar_points = hash['best_allstar_points']
        @best_combined_allstar_points = hash['best_combined_allstar_points']
        @possible_allstar_points = hash['possible_allstar_points']
        @historical_total = hash['historical_total']
        @historical_median = hash['historical_median']
        @historical_avg = hash['historical_avg']

        @data = hash['data']
        @data = []
        for data in hash['data']
          @data.push(ParseData.new(data))
        end
      end
    end
    # Specific parse info for a character on a given fight
    class ParseData
      attr_reader :character_id
      attr_reader :character_name
      attr_reader :persecondamount
      attr_reader :ilvl
      attr_reader :duration
      attr_reader :start_time
      attr_reader :report_code
      attr_reader :report_fight
      attr_reader :ranking_id
      attr_reader :guild
      attr_reader :total
      attr_reader :rank
      attr_reader :percent
      attr_reader :exploit
      attr_reader :banned
      attr_reader :historical_count
      attr_reader :historical_percent

      def initialize(hash)
        @character_id = hash['character_id']
        @character_name = hash['character_name']
        @persecondamount = hash['persecondamount']
        @ilvl = hash['ilvl']
        @duration = hash['duration']
        @start_time = hash['start_time']
        @report_code = hash['report_code']
        @report_fight = hash['report_fight']
        @ranking_id = hash['ranking_id']
        @guild = hash['guild']
        @total = hash['total']
        @rank = hash['rank']
        @percent = hash['percent']
        @exploit = hash['exploit']
        @banned = hash['banned']
        @historical_count = hash['historical_count']
        @historical_percent = hash['historical_percent']
      end
    end

    # Basic info for a uploaded Report
    class Report
      attr_reader :id
      attr_reader :title
      attr_reader :owner
      attr_reader :zone
      attr_reader :start
      attr_reader :end

      def initialize(hash)
        @id = hash['id']
        @title = hash['title']
        @owner = hash['owner']
        @zone = hash['zone']
        @start = hash['start']
        @end = hash['end']
      end
    end

    # class Fight
    #   attr_reader :id
    #   attr_reader :start_time
    #   attr_reader :end_time
    #   attr_reader :boss
    #   attr_reader :size
    #   attr_reader :difficulty
    #   attr_reader :kill
    #   attr_reader :partial
    #   attr_reader :standardComposition
    #   attr_reader :bossPercentage
    #   attr_reader :fightPercentage
    #   attr_reader :lastPhaseForPercentageDisplay
    #   attr_reader :name
    #   attr_reader :zoneID
    #   attr_reader :zoneName
    #
    #   def initialize(hash)
    #     @id = hash['id']
    #     @id = hash['start_time']
    #     @id = hash['end_time']
    #     @id = hash['id']
    #     @id = hash['id']
    #     @id = hash['id']
    #     @id = hash['id']
    #     @id = hash['id']
    #   end
    # end


  end
end
