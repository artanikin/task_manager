class TaskDecorator < Draper::Decorator
  delegate_all

  def created
    I18n.l(object.created_at.localtime, format: :short)
  end
end
