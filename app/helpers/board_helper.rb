module BoardHelper
  def square_index(row, col)
    "square_#{row}_#{col}"
  end

  def square_color(row, col)
    return 'light' if (row + col).even?

    'dark'
  end
end
