object word

attributes :id, :word_set_id, :text, :pronounciation, :learnt
child :meanings do |word|
  extends "meanings/show"
end

child :categories do |word|
  extends "categories/_base"
end
