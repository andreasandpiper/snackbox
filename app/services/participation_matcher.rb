class ParticipationMatcher
    def initialize(exchange)
      @exchange = exchange
    end

    def match()
        ActiveRecord::Base.transaction do
            @exchange.participation.map do |p|
                match = find_available_participation(p)
                p.update!(match_participation_id: match.id)
                match.update!(is_matched: true)
            end
        end
    end
    
    private
    
    def find_available_participation(p)
        available = @exchange.participation.where("is_matched IS ?", false).where("id != ?", p[:id])
        participation_from_other_team = available.where("team NOT LIKE ? ", p[:team])
        participation_from_other_team_and_state = participation_from_other_team.where("state NOT LIKE ?", p[:state])
        if (participation_from_other_team.empty?)
            if ((participation_from_other_team_and_state.empty?))
                return available.sample
            else
                return participation_from_other_team_and_state.sample
            end
        elsif (participation_from_other_team_and_state.empty?)
            return available.sample
        else
            return participation_from_other_team_and_state.sample
        end
    end
end
