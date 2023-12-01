class Notification < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :shift, optional: true
  belongs_to :absence, optional: true

  scope :by_recently_created, -> { order(created_at: :desc) }

  enum kind: {
    application: 0,
    approval: 1,
    approval_pending: 2,
    rejected: 3,
    unapplied: 4
  }

  def check_kind
    if shift_id.present?
      return "shift"
    elsif absence_id.present?
      return "absence"
    end
  end

  def check_item_id
    if shift_id.present?
      return shift_id
    elsif absence_id.present?
      return absence_id
    end
  end

  def shift_time
    if self.shift_id.present?
      self.shift.start_time.strftime('%Y/%m/%d %H:%M') + "-" + self.shift.end_time.strftime('%H:%M')
    elsif absence_id.present?
      self.absence.shift.start_time.strftime('%Y/%m/%d %H:%M') + "-" + self.absence.shift.end_time.strftime('%H:%M')
    end
  end
end
