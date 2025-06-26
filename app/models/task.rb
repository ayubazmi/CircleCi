# frozen_string_literal: true

class Task < ApplicationRecord
  before_save :set_status

  validates :name, presence: true

  belongs_to :user

  scope :ordered, -> { order(id: :desc) }
  scope :search, ->(name) { where("LOWER(name) LIKE ?", "%#{name.downcase}%") if name.present? }
  scope :filter_by_status, ->(status) { where(status:) if status.present? }

  def set_status
    self.status ||= "active"
  end

  def completed?
    self.status == "completed"
  end
end
