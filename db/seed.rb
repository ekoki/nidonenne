require "csv"

CSV.foreach('db/English_word.csv') do |row|
AutomaticQuestion.create(:question => row[0], :answer => row[1])
end