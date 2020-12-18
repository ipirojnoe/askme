module UsersHelper
  def incline(number, one, few, many)
    remainder10 = number % 10
    remainder100 = number % 100

    if remainder100 >= 11 && remainder100 <= 14
      return many
    end

    if remainder10 == 1
      return one
    end

    if remainder10 > 4 || remainder10 == 0
      return many
    end

    few
  end

  def user_background_color(user)
    user.background_color || '#005a55'
  end
end
