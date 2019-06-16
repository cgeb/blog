class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id

  validates :title, :content, presence: true

  def self.search(term)
    return all unless term

    Article.where("lower(title) LIKE :term OR lower(content) LIKE :term", term: "%#{term.downcase}%")
  end
end
