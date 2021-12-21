class LabelTask < ApplicationRecord
  belongs_to :label, optional: true
  belongs_to :task, optional: true
end
