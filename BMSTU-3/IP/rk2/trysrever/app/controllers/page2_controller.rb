# frozen_string_literal: true

# Controller for Page2
class Page2Controller < ApplicationController
  # Handles the result action
  def result
    @n = ''
    params.each do |key, value|
      Rails.logger.warn "Param #{key}: #{value}"
      @n = value if key == 'inputText'
    end
    @message = find_positive(@n)
  end

  # Finds positive elements in the array and performs calculations
  def find_positive(arr)
    @message = '
      <table>
      <thead>
          <tr>
              <th style="border-radius: 10px 0 0 10px;">Исходный массив</th>
              <th style="border-radius: 0 10px 10px 0;">Получившийся массив</th>
          </tr>
      </thead>
      <tbody id="tbody">
      '

    sum = 0
    count = 0
    arr = arr.split(' ')
    arr.each do |number|
      number = number.to_i
      if number.positive?
        sum += number
        count += 1
      end
    end

    flag = 0
    arr.each do |number|
      number = number.to_i
      if (number % 7).zero? && flag.zero?
        flag = 1
        @message += "
          <tr>
              <td>
                  #{number}
              </td>
              <td style='color:#07946E;font-weight:900;font-size:1.4em'>
                  #{count != 0 ? sum.to_f / count : 0}
              </td>
          </tr>"
      else
        @message += "<tr><td>#{number}</td> <td>#{number}</td></tr>"
      end
    end

    @message += '</tbody></table>'

    @message = '<p>Ошибка: не найден ни один элемент, кратный 7</p>' if flag.zero?
    @message = '<p>Предупреждение: введен пустой массив</p>' if arr.empty? # Fixed variable name
    @message += '<p>Предупреждение: Не найдено ни одного положительного элемента</p>' if sum.zero?
    @message
  end
end
