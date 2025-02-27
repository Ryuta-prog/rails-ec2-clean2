# frozen_string_literal: true

redirect_to admin_products_path, alert: t('admin.products.not_found')
redirect_to admin_products_path, notice: t('admin.products.created')
redirect_to admin_products_path, notice: t('admin.products.updated')
redirect_to admin_products_path, alert: t('admin.products.not_found') if @product.nil?
