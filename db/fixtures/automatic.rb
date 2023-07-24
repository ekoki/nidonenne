require "csv"

csv = CSV.read('db/fixtures/English_word.csv')
csv.each do |row|
  AutomaticQuestion.seed do |s|
  s.question = row[1]
  s.answer = row[0]
 end
end