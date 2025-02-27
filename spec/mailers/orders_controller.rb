# frozen_string_literal: true

redirect_to root_path, notice: t('orders.thanks')
flash.now[:alert] = t('orders.input_error')
