# frozen_string_literal: true

Rails.application.config.session_store :active_record_store,
                                       key: '_myapp_session',
                                       secure: Rails.env.production?,
                                       same_site: :lax,
                                       expire_after: 1.week
