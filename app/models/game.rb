class Game < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :levels

  validates_presence_of :name,
    :message => "Вы не ввели название"

  validates_uniqueness_of :name,
    :message => "Игра с таким названием уже существует"

  validates_presence_of :description,
    :message => "Вы не ввели описание"

  validates_presence_of :author

  validate :game_starts_in_the_future

  def draft?
    self.is_draft
  end

  def started?
    self.starts_at.nil? ? false : Time.now > self.starts_at
  end

protected

  def game_starts_in_the_future
    if self.starts_at and self.starts_at < Time.now
      self.errors.add(:starts_at, "Вы выбрали дату из прошлого. Так нельзя :-)")
    end
  end
end