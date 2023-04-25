class AnswerForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :answer, :text

  validates :answer, presence: true

end