require "csv"

CSV.foreach(Rails.root.join('db', 'English_word.csv')) do |row|
AutomaticQuestion.create!(:question => row[1], :answer => row[0])
end