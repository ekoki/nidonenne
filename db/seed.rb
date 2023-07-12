require "csv"

CSV.foreach(Rails.root.join('db', 'English_word.csv')) do |row|
AutomaticQuestion.create!(:id => row[2], :question => row[0], :answer => row[1])
end