# frozen_string_literal: true

namespace :data_migrations do
  desc 'Disable system dummy user'
  task disable_dummy_user: :environment do
    dummy_user = User.find_by(email: 'system@example.com', system_account: true)
    next unless dummy_user

    dummy_user.update!(
      password: SecureRandom.base64(64),
      locked_at: Time.current,
      system_account: false
    )

    # 修正後（RuboCop警告を無効化）
    PromotionCode.where(user: dummy_user).update_all(user_id: User.first.id) # rubocop:disable Rails/SkipsModelValidations
  end
end
