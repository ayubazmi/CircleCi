# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy

  def name
    email.split("@").first.capitalize
  end

  def total_tasks
    tasks.where(status: "active").count
  end

  def total_completed_tasks
    tasks.where(status: "completed")
  end
end
