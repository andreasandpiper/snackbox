# frozen_string_literal: true

class ParticipationMatcher
  def initialize(exchange)
    @participants = exchange.match_ready_participants
    @complete = false
  end

  def match
    ActiveRecord::Base.transaction do
      @participants.map do |p|
        match = find_available_participation(p)
        p.update!(match_participation_id: match.id)
        match.update!(is_matched: true)
      end
      @complete = true
    rescue
      raise ActiveRecord::Rollback
    end
  end

  def complete
    @complete
  end

  # in the unlikely, but possible case where someone ends up matched to themselves
  def order_match
    ActiveRecord::Base.transaction do
      @participants.reduce do |previous, current|
        previous.update!(match_participation_id: current.id)
        current.update!(is_matched: true)
        current
      end
        @participants.last.update!(match_participation_id: @participants.first.id)
        @participants.last.update!(is_matched: true)
        @complete = true
    rescue
      raise ActiveRecord::Rollback
    end
  end

  private
  
  def find_available_participation(p)
    available = @participants.where('id != ? AND is_matched IS ?', p[:id], false)
    participation_from_other_team = available.where('team NOT LIKE ? ', p[:team])
    participation_from_other_team_and_state = participation_from_other_team.where('state NOT LIKE ?', p[:state])
    if participation_from_other_team.empty?
      if participation_from_other_team_and_state.empty?
        available.sample
      else
        participation_from_other_team_and_state.sample
      end
    elsif participation_from_other_team_and_state.empty?
      available.sample
    else
      participation_from_other_team_and_state.sample
    end
  end
end
