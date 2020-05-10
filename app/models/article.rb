# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id

  validates :title, :content, presence: true
  has_rich_text :content

  def self.search(term)
    return all unless term

    Article.where("lower(title) LIKE :term", term: "%#{term.downcase}%")
  end
end
