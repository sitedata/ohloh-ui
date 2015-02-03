class FOSSerBadge < Badge
  def eligibility_count
    @count ||= vars[:positions_count]
    @count ||= Position.where(account_id: account.id).count
  end

  def name
    'FLOSSer'
  end

  def to_underscore
    'fosser'
  end

  def short_desc
    "contributes to free and open source software (FOSS)"
  end

  def level_limits
    [1, 3, 6, 10, 20, 50, 100, 200]
  end

  def position
    60
  end
end
