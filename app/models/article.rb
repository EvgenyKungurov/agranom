class Article < ApplicationRecord
  validates :title, length: { minimum: 6 }, presence: true
  validates :content, presence: true
end
