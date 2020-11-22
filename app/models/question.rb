class Question < ApplicationRecord
  validates :text, :answer, presence: true
end
