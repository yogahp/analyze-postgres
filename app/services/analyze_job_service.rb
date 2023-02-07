class AnalyzeJobService < BaseService
  def self.execute
    tables = current_tables - whitelist_tables
    tables.each do |table_name|
      Pg::AnalyzeJob.perform_async(table_name)
    end
  end

  def self.remove
    tables.each do |table_name|
      Rails.cache.delete("table_#{table_name}")
    end
  end

  def self.remaining_tables
    tables = Rails.cache.redis.keys("table_*").map { |table| table[6..-1] }
    current_tables - tables
  end

  private

  def whitelist_tables
    ["categories", "customers_invoices", "summary_invoices", "agent_summary_invoices", "commissions", "agent_summary_invoice_notes", "agent_commissions", "internal_tools_settings", "roles", "resources", "allowed_phone_prefixes", "agent_types", "inventory_check_history", "purchase_order_history", "purchase_order_history_details", "inventory_check_history_details", "inventory_item_costs", "feature_flags", "order_statuses", "order_types", "managed_whatsapp_templates", "order_cancel_reasons", "versions", "product_availability_per_day", "spatial_ref_sys", "category_commission_groups", "commission_groups", "provinces", "regencies", "email_blasts", "promo_special_price_products", "promo_events", "shareable_images", "courier_types", "conversions", "conversion_items", "external_api_clients", "total_price_limit_whitelists", "mission_groups", "mission_blacklists", "mission_whitelists", "freebie_promo_blocked_lists", "test_new_user", "test_new_user_2", "order_rating_options", "promo_types", "warehouse_groups", "warehouse_group_warehouses", "referral_banners", "referral_program_banners", "pick_list_daily_codes", "fulfillment_priorities", "trucks", "fees", "flash_sale_widget_banners", "flash_sale_widget_warehouse_groups", "unit_of_measures", "planogram_functionalities", "general_pick_list_item_actuals", "agent_type_commission_groups", "payment_method_fees", "inventory_production_restocks", "delivery_fee_warehouses", "delivery_fee_min_purchase_categories", "delivery_fee_min_purchase_frontend_categories", "courier_holidays", "courier_fees_components", "order_delivery_cancellations", "frontend_category_groups", "signatures", "inbound_signatures", "courier_punishment_types", "courier_punishments", "minimum_spending_fees", "thematic_widget_product_tags", "sdd_auto_assignment_global_configs", "failed_delivery_reasons", "payment_method_expirations", "thematic_widget_talon_one_rule_mappings", "force_majeure_types", "force_majeure_severities", "supplier_onboard_document_types", "supplier_onboard_samples", "order_queue_time_limit_global_configs", "blacklisted_passwords", "promo_labels", "product_frontend_labels", "product_user_subscriptions", "product_images", "force_majeure_confirmation_requests"]
  end

  def current_tables
    ActiveRecord::Base.connection.tables
  end
end