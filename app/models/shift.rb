class Shift < ApplicationRecord
  belongs_to :employee
  has_many :notifications, dependent: :destroy
  has_one :absence, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check

  enum status: { unapproved: 0, approved: 1, rejected: 2 }

  def start_end_check
    errors.add("end_time", "を開始時間より後にしてください。") if self.start_time >= self.end_time
  end

  def check_status
    if absence.present? && absence.status == "unapproved"
      return "absenceApplication"
    else
      return status
    end
  end

  def formalized_start_time
    start_time.strftime('%Y/%m/%d %H:%M')
  end

  def formalized_end_time
    end_time.strftime('%Y/%m/%d %H:%M')
  end
end
