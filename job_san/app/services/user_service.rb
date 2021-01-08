# frozen_string_literal: true

class UserService
  def initialize(user)
    @update_user = user
  end

  def update_user(params)
    return @update_user unless updatable_role_type?(params[:role_type])

    @update_user.update(params.except(:id))
    @update_user
  end

  private

  def updatable_role_type?(role_type)
    return true if role_type.blank?

    @update_user.errors.add(:role_type, 'は不正な値です') unless %w[admin member].include?(role_type)
    @update_user.errors.add(:base, '最後の管理者です') if User.admin.count < 2 && role_type == 'member'
    @update_user.errors.blank?
  end
end
