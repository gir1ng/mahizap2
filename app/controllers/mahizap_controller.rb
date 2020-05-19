class MahizapController < ApplicationController
  def index
    if @famous_quotes.nil?
      @famous_quotes = []
      File.open(Rails.root.to_s + '\app\assets\csv\famous_quote.csv', encoding: "Shift_JIS:UTF-8") do |file|
        file.each_line do |line|
          @famous_quotes.push(line)
        end
      end
    end
    @famous_quote = @famous_quotes.sample
  end
end
